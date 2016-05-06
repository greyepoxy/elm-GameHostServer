module Server.Routes  (Sitemap(..), match, render) where

import Route exposing (..)
import Shared.Async.Requests exposing (ApiPath, apiPaths)

type Sitemap
  = HomeR ()
  | AsyncClientR ApiPath

homeR = HomeR := static ""
sitemap = router [homeR, child AsyncClientR apiPaths]

match : String -> Maybe Sitemap
match = Route.match sitemap

render : Sitemap -> String
render r =
  case r of
    HomeR () -> Route.reverse homeR []
    AsyncClientR apiPath -> Shared.Async.Requests.render apiPath
