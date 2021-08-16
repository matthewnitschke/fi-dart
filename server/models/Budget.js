const mongoose = require('mongoose');

const BudgetSchema = new mongoose.Schema({
  accountId: String,
  date: String,
  // storeData: mongoose.Schema.Types.Mixed,
  storeData: String,
});

module.exports = mongoose.model('Budget', BudgetSchema);
