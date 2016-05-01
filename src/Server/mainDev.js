
var express = require('express');
var path = require('path');
var app = express();

app.use('/assets', express.static('dist/assets'));

var Elm = require('./Main.elm');
app.get('/', function(req, res) {
  var app = Elm.worker(Elm.Server.Main, {requests:null});
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
