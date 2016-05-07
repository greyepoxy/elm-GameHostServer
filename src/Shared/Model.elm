module Shared.Model (..) where


type alias AppModel = {
  clientMsg: String
  , serverMsg: Maybe String
}


initialModel : AppModel
initialModel = {
    clientMsg = "Hello!"
    , serverMsg = Nothing
  }
