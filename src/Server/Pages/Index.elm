module Server.Pages.Index exposing (..)

import Server.Assets exposing (IndexAssetPaths)
import Html exposing (..)
import Html.Attributes exposing (..)

meta: List (Attribute msg) -> List (Html msg) -> Html msg
meta attributes childNodes = node "meta" attributes childNodes

getHtml: IndexAssetPaths -> Html msg
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
      div [id "main"] []
      , node "script" [src assetPaths.js] []
    ]
  ]

