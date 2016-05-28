module Server.Requests exposing (..)

type alias RequestData = {
  method: String
  , path: String
  , body: Maybe String
}
