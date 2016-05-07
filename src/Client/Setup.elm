module Client.Setup (..) where

import Effects exposing (Effects, Never)
import Task exposing (Task)
import StartApp
import Shared.Messages exposing (..)
import Shared.Model exposing (..)
import Shared.Update exposing (..)
import Shared.View exposing (..)
import Client.Async.Functions exposing (clientAsyncFunctions)

init : ( AppModel, Effects Msg )
init = 
  ( initialModel, clientAsyncFunctions.getWhatServerSays )


app : List (Signal.Signal Msg) -> StartApp.App AppModel
app signals =
  StartApp.start
    { init = init
    , inputs = signals
    , update = updateWithFuncs clientAsyncFunctions
    , view = view
    }