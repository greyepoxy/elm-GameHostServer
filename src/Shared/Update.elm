module Shared.Update (..) where

import Shared.Model exposing (..)
import Shared.Messages exposing (..)
import Effects exposing (Effects)


update : Msg -> AppModel -> ( AppModel, Effects Msg )
update action model =
  case model.serverMsg of
    Nothing -> ( model, Effects.none )
    _ -> ( model, Effects.none )
