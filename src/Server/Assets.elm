module Server.Assets exposing (..)

type alias AllAssetPaths = {
  main: IndexAssetPaths
}

type alias IndexAssetPaths = {
  js: String
  , css: String
}
