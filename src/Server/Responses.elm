module Server.Responses (..) where

import Http.Response.Write exposing (writeNode)
import Server.Assets exposing (AllAssetPaths)
import Server.Requests exposing (RequestData)
import Server.Routes exposing (Sitemap(..), match)
import Server.Pages.Index as Index

import Server.Async.ClientRequests

type alias ResponseData = {
  status: Int
  , body: String
  , mimeType: String
}

getResponseForRequest : AllAssetPaths -> Maybe RequestData -> ResponseData
getResponseForRequest assets request =
  case request of 
    Just {method, path, body} ->
      case match path of
        Just sitemap ->
          case sitemap of
            HomeR () -> {status=200,body=(writeNode (Index.getHtml assets.main)),mimeType="html"}
            AsyncClientR apiPath ->
              let
                response = Server.Async.ClientRequests.handleRequest apiPath body
              in
                case response of
                  Just resBody ->
                    {status=200,body=resBody,mimeType="json"}
                  Nothing -> get404
        Nothing -> get404
    Nothing -> get404

get404 : ResponseData
get404 = {status=404,body="Page not found for request",mimeType="html"}
