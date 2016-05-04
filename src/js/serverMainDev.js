
var express = require('express');
var path = require('path');
var fs = require('fs');
var app = express();

app.use('/assets', express.static('dist/assets'));

var Elm = require('../ServerMain.elm');
app.get('/', function(req, res) {
  var assetFiles = JSON.parse(fs.readFileSync('dist/webpack-assets.json', 'utf8'));
  var app = Elm.worker(Elm.ServerMain, {requests:null, assets:assetFiles});
  app.ports.responses.subscribe(sendResponse);
  
  app.ports.requests.send({
    method: req.method,
    path: req.path
  });
  
  function sendResponse(data) {
    app.ports.responses.unsubscribe(sendResponse);
    
    res.status(data.status).type(data.mimeType).send(data.body);
  };
});

app.listen(3000, function() {
  console.log('Started server on port 3000.');
});
