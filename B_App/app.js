// 1. Install necessary dependencies
const express = require('express');
const bodyParser = require('body-parser');
const ejs = require('ejs');

// 2. Set up the express app
const app = express();
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));



app.get('/', function(req, res) {
    res.render('login');
    }
);

app.listen(3000, function() {
  console.log('Server started on port 3000');
});