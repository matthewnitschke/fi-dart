const { plaidClient, plaidEnv } = require('./plaid-utils.js');

const mongoose = require("mongoose");
const Transaction = require("../../models/Transaction");

const express = require("express");
const router = express.Router();

const Account = require("../../models/Account");

router.all("/accounts", async (req, res) => {
  const { email } = req.query;

  let accounts = await Account.find({
    ...(!!email && {
      email: { $regex: email, $options: "i" },
    }),
  });

  res.status(200).json(
    accounts.map(({ email, plaidAccessToken }) => {
      return {
        email,
        plaidAccessToken,
      };
    })
  );
});

router.all("/env", (req, res) => res.status(200).json({env: plaidEnv}))

router.post("/test-connection", async (req, res) => {
  const { email } = req.body;

  let account = await Account.findOne({email});

  plaidClient.getAccounts(account.plaidAccessToken, (error, accountsResp) => {
    if (error != null) {
      console.error(error);
      return res.status(500).json({
        error,
      });
    }
    console.log(accountsResp)
    res.status(200).json(accountsResp);
  });
});

router.post('/set-user-access-token', async (req, res, next) => {
  const { email, plaidAccessToken } = req.body;

  if (plaidAccessToken == null || plaidAccessToken == '') {
    res.status(500).json({ error: 'unable to set a null access token'})
  }

  await Account.update(
    { email },
    { plaidAccessToken }
  );

  res.sendStatus(200);
});


router.post('/syncTransactions', async (req, res) => {
  const { from, to, email } = req.body;

  console.log(from, to, email);
  
  let account = await Account.findOne({email});
  
  if (account.plaidAccessToken == null) {
    return res.status(500).json({
      error: 'Plaid ACCESS_TOKEN not initialized. If just set, try logging in and out again.'
    })
  }

  if (!from || !to) {
    return res.status(500).json({
      error: 'missing "from" or "to" query parameters'
    })
  }

  try {
    let response = await plaidClient.getTransactions(
      account.plaidAccessToken,
      from,
      to,
      {
        // account_ids: [],
        // count: 0,
        // offset: 0
      }
    );

    await Transaction.bulkWrite(
      response.transactions.map(transaction => ({
        updateOne: {
          filter: { _id: transaction.transaction_id },
          update: {
            _id: transaction.transaction_id,
            fiAccountId: req.session.accountId,
        
            date: transaction.date,
            name: transaction.name,
            merchantName: transaction.merchant_name,
            amount: transaction.amount,
            isPending: transaction.pending,

            raw: transaction
          },
          upsert: true,
        }
      }))
    );

  } catch(e) {
    console.error(e)
    return res.status(500).json({
      error: e
    });
  }

  res.status(200).send('OK')
});

module.exports = router;
