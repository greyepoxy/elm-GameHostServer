module ClientMain exposing (..)

import Html.App
import Shared.Messages exposing (..)
import Shared.Model exposing (..)
import Shared.Update exposing (..)
import Shared.View exposing (..)
import Client.Async.Functions exposing (clientAsyncFunctions)

main : Program Never
main =
  Html.App.program
    { init = init
    , subscriptions = (\_-> Sub.none)
    , update = updateWithFuncs clientAsyncFunctions
    , view = view
    }

init : ( AppModel, Cmd Message )
init = 
  ( initialModel, clientAsyncFunctions.getWhatServerSays )
