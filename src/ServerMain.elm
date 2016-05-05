module ServerMain (..) where

import Server.Assets exposing (AllAssetPaths)
import Server.Requests exposing (RequestData)
import Server.Responses exposing (ResponseData, getResponseForRequest)
import Signal


port requests : Signal (Maybe RequestData)

port responses : Signal ResponseData
port responses = Signal.map (getResponseForRequest assets) requests

port assets : AllAssetPaths
