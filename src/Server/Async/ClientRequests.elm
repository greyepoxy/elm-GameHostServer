module Server.Async.ClientRequests exposing (handleRequest)

import Shared.Async.Requests exposing (ApiPath(..), RootApiPath(..))
import Server.Requests exposing (RequestData)
--import Json.Decode exposing (Decoder, decodeString, tuple2, string)

handleRequest: Shared.Async.Requests.ApiPath -> RequestData -> Maybe String
handleRequest path req =
  case path of
    AsyncClientR (GetUserGameR gameQuery) ->
      Just (getGameInfo gameQuery)

getGameInfo: (Int, Int) -> String
getGameInfo (userId, gameId) =
  "\"" ++ toString userId ++ toString gameId ++ "\""
