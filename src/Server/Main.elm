module Server.Main (..) where

import Server.Routes exposing (Sitemap(..), match)
import Signal exposing (Mailbox)

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
      {status=200,body="Hello World!!!!",mimeType="html"}
    Nothing ->
      {status=200,body="Hello World!!!!",mimeType="html"}
