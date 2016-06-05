module Shared.SignIn exposing (..)

import Html exposing (..)
import Shared.Async.Functions exposing (AsyncFunctions)

type alias User = {
  id: String,
  displayName: String
}

type alias Model = {
  user: Maybe User
}

initialModel : Model
initialModel = {
    user = Nothing
  }

type Message = 
  SignIn User

updateWithFuncs : AsyncFunctions -> Message -> Model -> ( Model, Cmd Message )
updateWithFuncs funcs msg model =
  model ! []

view : Model -> Html Message
view model =
  button [] []
