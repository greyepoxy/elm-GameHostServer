port module ServerMain exposing (..)

import Server.Assets exposing (AllAssetPaths)
import Server.Requests exposing (RequestData)
import Server.Response exposing (ResponseData)
import Server.Responses exposing (getResponseForRequest, get404)
import Shared.Game.Model
import Shared.SignIn
import Html.App
import Html exposing (Html)
import Task

type alias Flags = {
    assetPaths: AllAssetPaths 
  }

type alias Model = {
    requestToResponedTo: Maybe RequestData
    , assetPaths: AllAssetPaths
  }

type Message =
  Start RequestData
  | ResponseReady ResponseData

update: Message -> Model -> (Model, Cmd Message)
update msg model =
  case msg of
    Start request -> 
      ({model|requestToResponedTo=(Just request)}, getResponseFromRequest model.assetPaths request)
    ResponseReady response -> (model, responses response)

main: Program Flags
main =
  Html.App.programWithFlags
  {
    init = (\flags -> ({requestToResponedTo= Maybe.Nothing, assetPaths=flags.assetPaths}, Cmd.none))
    , update = update
    , subscriptions = subscriptions
    --Need some kind of view to make the compiler happy but really
    -- doesn't matter because we only ever embed with worker which
    -- does not render
    , view  = (\_ -> Html.text "")
  }

getResponseFromRequest: AllAssetPaths -> RequestData -> Cmd Message
getResponseFromRequest assetPaths requestToResponedTo =
  Task.succeed (getResponseForRequest assetPaths requestToResponedTo)
    |> Task.perform (\_-> ResponseReady get404) (\response-> ResponseReady response)

port responses : ResponseData -> Cmd msg

port requests : (RequestData -> msg) -> Sub msg

port getPlayerGames : Shared.SignIn.User -> Cmd msg

port playerGames : (Shared.Game.Model.PlayerGames -> msg) -> Sub msg

subscriptions : Model -> Sub Message
subscriptions model =
  case model.requestToResponedTo of
    Just _ -> Sub.none
    Maybe.Nothing -> requests Start
