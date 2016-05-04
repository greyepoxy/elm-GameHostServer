module ClientMainDev (..) where

import Html exposing (..)
import Effects exposing (Effects, Never)
import Task exposing (Task)
import StartApp
import Shared.Actions exposing (..)
import Shared.Model exposing (..)
import Shared.Update exposing (..)
import Shared.View exposing (..)


init : ( AppModel, Effects Action )
init =
  ( initialModel, Effects.none )


app : StartApp.App AppModel
app =
  StartApp.start
    { init = init
    , inputs = [swapsignal]
    , update = update
    , view = view
    }


main : Signal Html
main =
  app.html


port runner : Signal (Task Never ())
port runner =
  app.tasks

-- for elm-hot-loader to trigger a re-render
port swap : Signal Bool

-- map swap to Empty action
swapsignal : Signal Action
swapsignal =
  Signal.map (\_ -> NoOp) swap
