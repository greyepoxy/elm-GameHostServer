module Client.Async.Functions (clientAsyncFunctions) where

import Client.Async.Requests exposing (getGameInformation)
import Shared.Async.Functions exposing (AsyncFunctions)
import Shared.Messages exposing (Msg(NewServerMsg))
import Effects exposing (Effects)
import Task
import Http

clientAsyncFunctions: AsyncFunctions
clientAsyncFunctions = {
    getWhatServerSays = getWhatServerSays
  }

getWhatServerSays: Effects Msg
getWhatServerSays = 
  (getGameInformation 5 10)
    |> Task.toResult
    |> Task.map mapResultToMsg
    |> Effects.task

mapResultToMsg: Result Http.Error String -> Msg
mapResultToMsg result =
  case result of
    Ok serverMsg -> NewServerMsg serverMsg
    Err httpErr ->
      case httpErr of
        Http.Timeout -> NewServerMsg "Timeout"
        Http.NetworkError -> NewServerMsg "NetworkError"
        Http.UnexpectedPayload errMsg -> NewServerMsg ("UnexpectedPayload:" ++ errMsg)
        Http.BadResponse status errMsg -> NewServerMsg ("BadResponse:" ++ errMsg)
  