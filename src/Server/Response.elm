module Server.Response exposing (..)

type alias ResponseData = {
  status: Int
  , body: String
  , mimeType: String
}
