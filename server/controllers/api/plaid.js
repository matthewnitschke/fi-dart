
const mongoose = require('mongoose');
const Transaction = require('../../models/Transaction');

const { plaidClient, plaidEnv } = require('./plaid-utils.js');

const express = require('express');
const router = express.Router();

const Account = require('../../models/Account');

router.get('/getBankAccounts', async (req, res) => {
  if (req.session.plaidAccessToken == null) {
    return res.status(500).json({
      error: 'Plaid ACCESS_TOKEN not initialized. If just set, try logging in and out again.'
    })
  }

  plaidClient.getAccounts(req.session.plaidAccessToken, (error, accountsResp) => {
    if (error != null) {
      console.error(error);
      return res.status(500).json({
        error
      });
    }

    res.status(200).json(accountsResp);
  })
});

router.get('/syncTransactions', async (req, res) => {
  const { from, to } = req.query;

  if (req.session.plaidAccessToken == null) {
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
      req.session.plaidAccessToken,
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
            merchant: transaction.name,
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

router.delete('/allTransactions', async (req, res) => {
  if (req.session.plaidAccessToken == null) {
    return res.status(500).json({
      error: 'Plaid ACCESS_TOKEN not initialized. If just set, try logging in and out again.'
    })
  }

  await Transaction.deleteMany({
    fiAccountId: req.session.accountId
  })

  res.status(200).send('OK');
})

module.exports = router;
