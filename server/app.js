const path = require('path');

const express = require('express');
const session = require('express-session');
const MongoStore = require('connect-mongo')(session);
const mongoose = require('mongoose');
const authentication = require('./middleware/authentication');

const app = express();
const port = 8888;

// a list of routes that are acceptable and serve the index.html file
const availableRoutes = ['/', '/plaid-admin'];

(async () => {
  await require('./db')(); // ensure db is initialized

  
  app.use(
    session({
      secret: process.env.SESSION_SECRET ?? 'secret-dev-stuff',
      store: new MongoStore({ mongooseConnection: mongoose.connection }),
    })
  );
  
  app.use(express.urlencoded({ extended: false }));
  app.use(express.json());
  
  app.use('/login', require('./controllers/login'));
    
  availableRoutes.forEach((route) => {
    app.use(route, express.static(path.join(__dirname, '../client/build/web')))
  })
  
  app.use(authentication);
  app.use('/budget', require('./controllers/api/budget'));
  app.use('/transactions', require('./controllers/api/transactions'));
  app.use('/plaid', require('./controllers/api/plaid'));
  app.use('/plaid-admin', require('./controllers/api/plaid-admin'));

  app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
  });
})();
