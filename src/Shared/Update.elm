module Shared.Update exposing (..)

import Shared.Async.Functions exposing (AsyncFunctions)
import Shared.Model exposing (..)
import Shared.Messages exposing (..)


updateWithFuncs : AsyncFunctions -> Message -> AppModel -> ( AppModel, Cmd Message )
updateWithFuncs funcs msg model =
  case msg of
    NoOp -> ( model, Cmd.none)
    NewServerMsg result ->
      ({model | serverMsg= Just result}, Cmd.none)
