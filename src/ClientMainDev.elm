module ClientMainDev (..) where

import Html exposing (..)
import Effects exposing (Effects, Never)
import Task exposing (Task)
import StartApp
import Client.Setup
import Shared.Model exposing (..)
import Shared.Messages exposing (..)

app : StartApp.App AppModel
app = Client.Setup.app [swapsignal]


main : Signal Html
main =
  app.html


port runner : Signal (Task Never ())
port runner =
  app.tasks

-- for elm-hot-loader to trigger a re-render
port swap : Signal Bool

-- map swap to Empty action
swapsignal : Signal Msg
swapsignal =
  Signal.map (\_ -> NoOp) swap
