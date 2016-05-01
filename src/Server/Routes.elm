module Server.Routes  (Sitemap(..), match, route) where

import Route exposing (..)

type Sitemap
  = HomeR ()

homeR = HomeR := static ""
sitemap = router [homeR]

match : String -> Maybe Sitemap
match = Route.match sitemap

route : Sitemap -> String
route r =
  case r of
    HomeR () -> Route.reverse homeR []
