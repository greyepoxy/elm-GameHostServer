module Shared.SignIn exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Task

type alias User = {
  id: String,
  displayName: String
}

type alias Model = {
  user: Maybe User
}

initialModel : Model
initialModel = {
    user = Nothing
  }

type Message = 
  StartSignIn
  | StartSignOut
  | SignIn User

update : Message -> Model -> ( Model, Cmd Message )
update msg model =
  case msg of
    StartSignIn ->
      model ! [signInFakeUser]
    StartSignOut ->
      { model | user = Nothing} ! []
    SignIn user ->
      { model | user= Just user} ! []

signInFakeUser : Cmd Message
signInFakeUser =
  Task.perform (\_-> SignIn fakeUser) (\_-> SignIn fakeUser) (Task.succeed 0)

fakeUser : User
fakeUser = {
    id="1"
    , displayName="Fake User"
  }

view : Model -> Html Message
view model =
  case model.user of
    Nothing ->
      button [onClick StartSignIn] [text "Log In"]
    Just user ->
      div []
        [ text user.displayName
          , button [onClick StartSignOut] [text "Log Out"]
        ]
