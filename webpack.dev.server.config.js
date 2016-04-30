var webpack = require('webpack');
var path = require('path');
var fs = require('fs');

var nodeModules = {};
fs.readdirSync('node_modules')
  .filter(function(x) {
    return ['.bin'].indexOf(x) === -1;
  })
  .forEach(function(mod) {
    nodeModules[mod] = 'commonjs ' + mod;
  });

module.exports = {
  entry: {
    main: ['./src/Server/mainDev.js']
  },
  target: 'node',
  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: 'server.[name].js'
  },
  externals: nodeModules
}
