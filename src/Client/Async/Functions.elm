module Client.Async.Functions exposing (clientAsyncFunctions)

import Client.Async.Requests exposing (getGameInformation)
import Shared.Async.Functions exposing (AsyncFunctions)
import Shared.Messages exposing (Message(NewServerMsg))
import Task
import Http

clientAsyncFunctions: AsyncFunctions
clientAsyncFunctions = {
    getWhatServerSays = getWhatServerSays
  }

getWhatServerSays: Cmd Message
getWhatServerSays = 
  (getGameInformation 5 10)
    |> Task.perform mapHttpErrorToMsg mapServerResponseToMsg

mapHttpErrorToMsg: Http.Error -> Message
mapHttpErrorToMsg httpErr =
  case httpErr of
    Http.Timeout -> NewServerMsg "Timeout"
    Http.NetworkError -> NewServerMsg "NetworkError"
    Http.UnexpectedPayload errMsg -> NewServerMsg ("UnexpectedPayload:" ++ errMsg)
    Http.BadResponse status errMsg -> NewServerMsg ("BadResponse:" ++ errMsg)

mapServerResponseToMsg: String -> Message
mapServerResponseToMsg response =
  NewServerMsg response
  