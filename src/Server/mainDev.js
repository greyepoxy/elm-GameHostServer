
var express = require('express');
var path = require('path');
var app = express();

app.use('/assets', express.static('dist/assets'));

app.get('/', function(req, res) {
  res.send('Hello World!');
});

app.listen(3000, function() {
  console.log('Started server on port 3000.');
});
