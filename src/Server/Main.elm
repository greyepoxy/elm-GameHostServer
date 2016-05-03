module Server.Main (..) where

import Native.Http.Response.Write
import Server.Assets exposing (AllAssetPaths)
import Server.Routes exposing (Sitemap(..), match)
import Server.Pages.Index as Index
import Signal

type alias RequestData = {
  method: String
  , path: String
}

port requests : Signal (Maybe RequestData)

type alias ResponseData = {
  status: Int
  , body: String
  , mimeType: String
}

port responses : Signal ResponseData
port responses = Signal.map getResponseForRequest requests

getResponseForRequest : Maybe RequestData -> ResponseData
getResponseForRequest request =
  case request of 
    Just {method, path} ->
      {status=200,body=(Native.Http.Response.Write.toHtml (Index.getHtml assets.main)),mimeType="html"}
    Nothing ->
      {status=200,body="Hello World!!!!",mimeType="html"}

port assets : AllAssetPaths
