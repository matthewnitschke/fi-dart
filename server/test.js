const path = require('path');
const express = require('express');

const app = express();
const port = 8888;

app.use(express.static(path.join(__dirname, '../client/build/web')));
// app.use(express.static(path.join(__dirname, '../client')));

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});