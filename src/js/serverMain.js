
var express = require('express');
var path = require('path');
var fs = require('fs');
var bodyParser = require('body-parser');
var https = require('https');
var app = express();

app.use(bodyParser.text())
app.use('/assets', express.static('dist/assets'));

app.get('/game/:rootpath*', function(req, res) {
  var splitRootPath = req.params.rootpath.split('/', 1);
  var version = splitRootPath[0];
  //TODO: validate version is a guid
  var requestOptions = {
    host: 'api.github.com',
    path: '/repos/greyepoxy/elm-tick-tack-toe/contents/src/Main.elm?ref=' + version,
    headers: {
      'User-Agent': 'greyepoxy/elm-GameHostServer'
    }
  };
  console.log('Making request to "'+requestOptions.host +requestOptions.path+'"')
  //Looks like I can also download the file directly using
  // https://raw.githubusercontent.com/greyepoxy/elm-tick-tack-toe/<sha>/src/Main.elm
  
  https.get(requestOptions, function (githubRes) {
    console.log('Got response: ' +githubRes.statusCode);
    console.log('HEADERS: '+ JSON.stringify(githubRes.headers));
    githubRes.setEncoding('utf8');
    githubRes.on('data', function (chunk) {
      console.log('BODY: ' + chunk);
    });
    githubRes.on('end', function() {
      console.log('No more data in response.')
    });
  }).on('error', function (e) {
    console.log('problem with request: ' + e.message);
  });
  
  res.status(200).type('html').send('No crash!');
});

var Elm = require('../ServerMain.elm');
app.get('/*', function(req, res) {
  var assetFiles = JSON.parse(fs.readFileSync('dist/webpack-assets.json', 'utf8'));
  var app = Elm.ServerMain.worker({assetPaths:assetFiles});
  app.ports.responses.subscribe(sendResponse);
  
  setTimeout(function() { 
      app.ports.requests.send({
        method: req.method,
        path: req.path,
        body: app.body || null
      }); 
    }, 0);
  
  function sendResponse(data) {
    app.ports.responses.unsubscribe(sendResponse);
    
    res.status(data.status).type(data.mimeType).send(data.body);
  };
});

app.listen(3000, function() {
  console.log('Started server on port 3000.');
});
