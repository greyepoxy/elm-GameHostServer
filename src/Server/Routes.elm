module Server.Routes  (Sitemap(..), match, route) where

import Route exposing (..)
import Shared.Async.Requests exposing (ApiPath, apiPaths)

type Sitemap
  = HomeR ()
  | AsyncClientR ApiPath

homeR = HomeR := static ""
asyncClientR = "async" <//> child AsyncClientR apiPaths
sitemap = router [homeR, asyncClientR]

match : String -> Maybe Sitemap
match = Route.match sitemap

route : Sitemap -> String
route r =
  case r of
    HomeR () -> Route.reverse homeR []
    AsyncClientR apiPath -> Route.reverse asyncClientR []
