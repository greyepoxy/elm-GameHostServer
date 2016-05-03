module Server.Pages.Index (..) where

import Server.Assets exposing (IndexAssetPaths)
import Html exposing (..)
import Html.Attributes exposing (..)

meta: List Attribute -> List Html -> Html
meta attributes childNodes = node "meta" attributes childNodes

getHtml: IndexAssetPaths -> Html
getHtml assetPaths =
  node "html" [lang "en-us"]
  [
    node "head" []
    [
      meta [charset "utf-8"] []
      , meta [name "viewport", content "width=device-width, initial-scale=1"] []
      , meta [name "description", content "Chess in the browser"] []
      , meta [name "author", content "greyepoxy"] []
      , node "title" [] [text "Chess"]
      , node "link" [href assetPaths.css, rel "stylesheet"] [] 
    ]
    , body []
    [
      div [id "main"] [text "If you have JavaScript enabled this page is now loading..."]
      , node "script" [src assetPaths.js] []
    ]
  ]
