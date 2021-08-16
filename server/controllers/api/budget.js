const Budget = require('../../models/Budget');
const Transaction = require('../../models/Transaction');

const express = require('express');
const router = express.Router();


router.get('/:year/:month', async (req, res) => {
  const { year, month } = req.params;
  const { accountId } = req.session;

  const foundBudget = await Budget.findOne({
    accountId: accountId,
    date: `${year}/${month}`,
  });

  if (foundBudget == null) {
    res.status(404).json({ error: 'budget not found' })
    return
  }

  res.status(200).json(JSON.parse(foundBudget.storeData));
});

router.post('/:year/:month', async (req, res) => {
  const { year, month } = req.params;
  const { accountId } = req.session;

  const foundBudget = await Budget.findOne({
    accountId: accountId,
    date: `${year}/${month}`,
  });

  if (foundBudget) {
    await Budget.findOneAndUpdate(
      {
        _id: foundBudget._id,
      },
      {
        storeData: req.body.serializedStore,
      }
    );
  } else {
    let newBudget = new Budget({
      accountId,
      date: `${year}/${month}`,
      storeData: req.body.serializedStore,
    });

    await newBudget.save();
  }

  res.sendStatus(200);
});

router.delete('/:year/:month', async (req, res) => {
  const { year, month } = req.params;
  const { accountId } = req.session;

  await Budget.findOneAndDelete({
    accountId: accountId,
    date: `${year}/${month}`,
  });

  res.status(200).send('OK');
});

module.exports = router;
