var path = require('path');
var HtmlWebpackPlugin = require( 'html-webpack-plugin' );
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var AssetsPlugin = require('assets-webpack-plugin');

var assetsFolderName = '/assets/';

var getAssetDistFolder = function(outputPath){
  return path.join(outputPath, assetsFolderName);
}

module.exports = {
  commonClientConfig: {
    resolve: {
      modulesDirectories: ['node_modules'],
    },
  },
  
  getIndexFileConfig: function(outputPath) {
    return {
      entry: {
        main: [
          './src/js/clientMain.js'
        ]
      },
      
      output: {
        filename: 'client.[name].[hash].js',
        path: getAssetDistFolder(outputPath)
      },
      
      module: {
        loaders: [
          {
            test: /\.(css)$/,
            loader: ExtractTextPlugin.extract("style-loader", "css-loader")
          },
          {
            test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
            loader: 'url-loader?limit=10000&minetype=application/font-woff',
          },
          {
            test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
            loader: 'file-loader',
          },
          {
            test: /\.(png|jpg)(\?v=[0-9]\.[0-9]\.[0-9])?$ /,
            loader: 'url-loader?limit=10000![name].[ext]?[hash]'
          }
        ],
      },
      
      plugins: [
        new ExtractTextPlugin('styles.[hash].css'),
        new AssetsPlugin({path: outputPath})
      ],
    }
  },
  
  indexEntryConfig: {
    output: {
      publicPath: assetsFolderName
    },
  },
  
  indexDevEntryConfig: {
    output: {
      publicPath: "http://localhost:3010/assets/"
    },
  },
  
  getTestFileConfig: function(outputPath) {
    return {
      entry: {
        tests: [
          './src/js/tests.js'
        ]
      },

      output: {
        path: getAssetDistFolder(outputPath),
        filename: '[name].js',
      },
      
      plugins: [
        new HtmlWebpackPlugin({
          template: 'src/js/testIndex.html',
          inject:   'body',
          filename: 'index.html'
        }),
      ]
    }
  },
  
  elmHotLoaderConfig: {
    module: {
      loaders: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader: 'elm-hot!elm-webpack'
        }
      ],
      noParse: /\.elm$/,
    }
  },

};