module Server.Async.ClientRequests (handleRequest) where

import Shared.Async.Requests
import Json.Decode exposing (Decoder, decodeString, tuple2, string)

handleRequest: Shared.Async.Requests.ApiPath -> String -> Maybe String
handleRequest path requestBody =
  case path of
    Shared.Async.Requests.GetWordsAppended () ->
      let
        params = decodeString decodeStringTuple requestBody
      in
        Result.map Shared.Async.Requests.getWordsAppendedFunc params
          |> Result.map toString
          |> Result.toMaybe

decodeStringTuple: Decoder (String, String)
decodeStringTuple = tuple2 (,) string string
