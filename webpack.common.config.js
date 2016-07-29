module.exports = {
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
  }
};
