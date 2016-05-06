module Shared.View (..) where

import Html exposing (..)
import Shared.Messages exposing (..)
import Shared.Model exposing (..)


view : Signal.Address Msg -> AppModel -> Html
view address model =
  div []
  [ 
    div [] [text ("Client says: " ++ model.clientMsg)]
    , div [] [text ("Server says: " ++ toString model.serverMsg)] 
  ]
