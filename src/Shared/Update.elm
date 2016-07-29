module Shared.Update exposing (..)

import Shared.Async.Functions exposing (AsyncFunctions)
import Shared.Model exposing (..)
import Shared.Messages exposing (..)
import Shared.SignIn


updateWithFuncs : AsyncFunctions -> Message -> AppModel -> ( AppModel, Cmd Message )
updateWithFuncs funcs msg model =
  case msg of
    NewServerMsg result ->
      {model | serverMsg= Just result} ! []
    SignInMsg msg ->
      let
        (newSignInInfo, signInCmds) = Shared.SignIn.update msg model.signInInfo
      in
        {model | signInInfo = newSignInInfo} ! [Cmd.map SignInMsg signInCmds]
