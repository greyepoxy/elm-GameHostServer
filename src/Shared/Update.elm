module Shared.Update (..) where

import Shared.Async.Functions exposing (AsyncFunctions)
import Shared.Model exposing (..)
import Shared.Messages exposing (..)
import Effects exposing (Effects)


updateWithFuncs : AsyncFunctions -> Msg -> AppModel -> ( AppModel, Effects Msg )
updateWithFuncs funcs msg model =
  case msg of
    NoOp -> ( model, Effects.none)
    NewServerMsg result ->
      ({model | serverMsg= Just result}, Effects.none)
