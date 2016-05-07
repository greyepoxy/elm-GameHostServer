module ClientMain (..) where

import Html exposing (..)
import Effects exposing (Effects, Never)
import Task exposing (Task)
import StartApp
import Client.Setup
import Shared.Model exposing (..)

app : StartApp.App AppModel
app = Client.Setup.app []


main : Signal Html
main =
  app.html


port runner : Signal (Task Never ())
port runner =
  app.tasks