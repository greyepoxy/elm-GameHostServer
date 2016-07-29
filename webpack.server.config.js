var merge = require( 'webpack-merge' );
var elmConfig = require('./webpack.common.config.js').elmConfig;
var path = require('path');
var fs = require('fs');

var nodeModules = {};
var packageJson = require('./package.json');
for (var mod in packageJson.dependencies) {
  nodeModules[mod] = 'commonjs ' + mod;
}

module.exports = {
  getServerConfig: function(outputPath) {
    return merge(
      {
        entry: {
          main: ['./src/js/serverMain.js']
        },
        target: 'node',
        output: {
          path: outputPath,
          filename: 'server.[name].js'
        },
        externals: nodeModules,
        plugins: []
      },
      elmConfig
    );
  }
};
