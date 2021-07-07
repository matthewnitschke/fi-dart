module.exports = (req, res, next) => {
  // req.session.accountId = "5fbfe7509a758581b265a7f5";
  // req.session.bankAccountIds = ["someid"]
  // next();
  
  console.log(`accountId: ${req.session.accountId}`)

  if (req.session.accountId != null) {
    next();
  } else {
    console.log('Not authenticated')
    res.redirect('/login');
    // res.status(401).send("Not Authenticated");
  }
};
