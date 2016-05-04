module Shared.Update (..) where

import Shared.Model exposing (..)
import Shared.Actions exposing (..)
import Effects exposing (Effects)


update : Action -> AppModel -> ( AppModel, Effects Action )
update action model =
  ( model, Effects.none )
