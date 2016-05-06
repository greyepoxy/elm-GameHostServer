module ServerMain (..) where

import Server.Assets exposing (AllAssetPaths)
import Server.Requests exposing (RequestData)
import Server.Response exposing (ResponseData)
import Server.Responses exposing (getResponseForRequest)
import Signal


port requests : Signal (Maybe RequestData)

port responses : Signal ResponseData
port responses = Signal.map (getResponseForRequest assets) requests

port assets : AllAssetPaths
