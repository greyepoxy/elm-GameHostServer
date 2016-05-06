module Server.Response (..) where

type alias ResponseData = {
  status: Int
  , body: String
  , mimeType: String
}
