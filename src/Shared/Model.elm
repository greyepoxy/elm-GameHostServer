module Shared.Model exposing (..)

import Shared.SignIn

type alias AppModel = {
  clientMsg: String
  , serverMsg: Maybe String
  , signInInfo: Shared.SignIn.Model
}


initialModel : AppModel
initialModel = {
    clientMsg = "Hello!"
    , serverMsg = Nothing
    , signInInfo = Shared.SignIn.initialModel
  }
