module Shared.Messages exposing (..)

import Shared.SignIn

type Message
  = NewServerMsg String
  | SignInMsg Shared.SignIn.Message
