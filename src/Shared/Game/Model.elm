module Shared.Game.Model exposing (..)

type alias PlayerGames = {
  playerId: Int,
  gameInfos: List Info
}

type alias Info = {
  id: Int
}

type alias Model = {
  info: Info
}
