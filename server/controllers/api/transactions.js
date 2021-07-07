const Transaction = require('../../models/Transaction');

const express = require('express');
const router = express.Router();

router.get('/', async (req, res) => {
  const { from, to } = req.query;

  let transactions = await Transaction.find({
    fiAccountId: req.session.accountId,
    date: { $gte: new Date(from), $lte: new Date(to) },
  });

  res.status(200).send(transactions);
});

router.get('/:transactionId', async (req, res) => {
  const { transactionId } = req.params;

  let transaction = await Transaction.findOne({
    _id: transactionId,
    fiAccountId: req.session.accountId,
  });

  res.status(200).json(transaction);
});


module.exports = router;
