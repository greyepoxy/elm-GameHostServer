module Shared.Async.Functions exposing (..)

import Shared.Messages exposing (..)

type alias AsyncFunctions = {
  getWhatServerSays: Cmd Message
}
