
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
