module Shared.View (..) where

import Html exposing (..)
import Shared.Actions exposing (..)
import Shared.Model exposing (..)


view : Signal.Address Action -> AppModel -> Html
view address model =
  div
    []
    [ text "Hello!!!" ]
