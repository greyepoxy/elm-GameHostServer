module Client.Async.Requests exposing (..)

import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (..)
import Shared.Async.Requests exposing (render, ApiPath(..), RootApiPath(..))

getGameInformation: Int -> Int -> Task Http.Error String
getGameInformation userId gameId =
  Http.get gameInfo (render (AsyncClientR (GetUserGameR (userId, gameId))))

gameInfo: Json.Decoder String
gameInfo =
  Json.string
