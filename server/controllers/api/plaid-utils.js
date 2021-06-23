const plaid = require('plaid');

const plaidEnv = plaid.environments.development;

const plaidClient = new plaid.Client({
    clientID: process.env.PLAID_CLIENT_ID,
    secret: process.env.PLAID_SECRET,
    env: plaid.environments.development,
    options: {
        version: "2019-05-29",
    },
});

module.exports = { plaidClient, plaidEnv }