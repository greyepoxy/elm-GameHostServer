module Shared.Model (..) where


type alias AppModel = {
  clientMsg: String
  , serverMsg: Maybe String
  , requestInProgress: Bool
}


initialModel : AppModel
initialModel = {
    clientMsg = "Hello!"
    , serverMsg = Nothing
    , requestInProgress = False
  }
