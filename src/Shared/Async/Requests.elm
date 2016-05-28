module Shared.Async.Requests exposing (..)

import Route exposing (..)

type RootApiPath
  = GetUserGameR (Int, Int)

getUserGameR = GetUserGameR := "user" <//> int </> "game" <//> int
rootApiPaths = router [getUserGameR]

renderRoot: RootApiPath -> String
renderRoot r =
  case r of
    GetUserGameR (userId, gameId) -> Route.reverse getUserGameR [toString userId, toString gameId]

type ApiPath
  = AsyncClientR RootApiPath

asyncClientR = "async" <//> child AsyncClientR rootApiPaths

apiPaths = router [asyncClientR]

match : String -> Maybe ApiPath
match = Route.match apiPaths

render : ApiPath -> String
render r =
  case r of
    AsyncClientR rootR -> Route.reverse asyncClientR [] ++ renderRoot rootR
