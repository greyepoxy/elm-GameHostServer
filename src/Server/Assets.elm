module Server.Assets (..) where

type alias AllAssetPaths = {
  main: IndexAssetPaths
}

type alias IndexAssetPaths = {
  js: String
  , css: String
}
