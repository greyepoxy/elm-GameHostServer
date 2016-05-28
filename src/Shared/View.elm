module Shared.View exposing (..)

import Html exposing (..)
import Shared.Messages exposing (..)
import Shared.Model exposing (..)


view : AppModel -> Html Message
view model =
  div []
  [ 
    div [] [text ("Client says: " ++ model.clientMsg)]
    , div [] [text ("Server says: " ++ toString model.serverMsg)] 
  ]
