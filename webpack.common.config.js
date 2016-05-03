var path = require("path");
var HtmlWebpackPlugin = require( 'html-webpack-plugin' );
var ExtractTextPlugin = require("extract-text-webpack-plugin");
var AssetsPlugin = require('assets-webpack-plugin');

var distFolder = path.resolve(path.join(__dirname, 'dist'));
var assetsFolderName = "/assets/";
var assetDistFolder = path.join(distFolder, assetsFolderName);

module.exports = {
  
  commonClientConfig: {
    resolve: {
      modulesDirectories: ['node_modules'],
    },
    
    plugins: [
      new ExtractTextPlugin('styles.[hash].css'),
      new AssetsPlugin({path: distFolder})
    ],

  },
  
  indexFileConfig: {
    output: {
      path: assetDistFolder
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
  },
  
  indexEntryConfig: {
    entry: {
      main: [
        './src/Client/main.js'
      ]
    },
    output: {
      filename: 'client.[hash].js',
      publicPath: assetsFolderName
    },
  },
  
  indexDevEntryConfig: {
    entry: {
      main: [
        './src/Client/mainDev.js'
      ]
    },
    output: {
      filename: 'client.[name].js',
      publicPath: "http://localhost:3010/assets/"
    },
  },
  
  testFileConfig: {
    entry: {
      tests: [
        './src/tests.js'
      ]
    },

    output: {
      path: assetDistFolder,
      filename: '[name].js',
    },
  },
  
  devConfig: {

    devServer: {
      stats: 'errors-only'
    },
  },
  
  elmConfig: {
    module: {
      loaders: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader: 'elm-webpack'
        }
      ],
      noParse: /\.elm$/,
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