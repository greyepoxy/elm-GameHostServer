module Server.Pages.Index (..) where

import Html exposing (..)
import Html.Attributes exposing (..)

meta: List Attribute -> List Html -> Html
meta attributes childNodes = node "meta" attributes childNodes

getHtml: Html
getHtml =
  node "html" [lang "en-us"]
  [
    node "head" []
    [
      meta [charset "utf-8"] []
      , meta [name "viewport", content "width=device-width, initial-scale=1"] []
      , meta [name "description", content "Chess in the browser"] []
      , meta [name "author", content "greyepoxy"] []
      , node "title" [] [text "Chess"]
      , node "link" [href "/assets/styles.3b69569f8e7c6ba2ad06.css", rel "stylesheet"] [] 
    ]
    , body []
    [
      div [id "main"] [text "If you have JavaScript enabled this page is now loading..."]
      , node "script" [src "/assets/client.main.js"] []
    ]
  ]
