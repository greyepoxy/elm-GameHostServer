module Shared.View exposing (..)

import Html exposing (..)
import Html.App
import Shared.Messages exposing (..)
import Shared.Model exposing (..)
import Shared.SignIn

view : AppModel -> Html Message
view model =
  div []
  [ 
    div [] [Html.App.map SignInMsg (Shared.SignIn.view model.signInInfo)]
    , div [] [text ("Client says: " ++ model.clientMsg)]
    , div [] [text ("Server says: " ++ toString model.serverMsg)] 
  ]
