module Server.Responses exposing (..)

import Http.Response.Write exposing (writeNode)
import Server.Assets exposing (AllAssetPaths)
import Server.Requests exposing (RequestData)
import Server.Response exposing (ResponseData)
import Server.Routes exposing (Sitemap(..), match)
import Server.Pages.Index as Index

import Server.Async.ClientRequests

getResponseForRequest : AllAssetPaths -> RequestData -> ResponseData
getResponseForRequest assets request =
    case match request.path of
      Just sitemap ->
        case sitemap of
          HomeR () -> {status=200,body=(writeNode (Index.getHtml assets.main)),mimeType="html"}
          AsyncClientR apiPath ->
            let
              response = Server.Async.ClientRequests.handleRequest apiPath request
            in
              case response of
                Just resBody ->
                  {status=200,body=resBody,mimeType="json"}
                Nothing -> get404
      Nothing -> get404

get404 : ResponseData
get404 = {status=404,body="Page not found for request",mimeType="html"}
