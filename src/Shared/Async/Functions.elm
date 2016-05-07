module Shared.Async.Functions (..) where

import Effects exposing (Effects)
import Shared.Messages exposing (..)

type alias AsyncFunctions = {
  getWhatServerSays: Effects Msg
}
