module Shared.Async.Requests (..) where

import Route exposing (..)

type ApiPath
  = GetWordsAppended ()

getWordsAppended = GetWordsAppended := static "getWordsAppended"
apiPaths = router [getWordsAppended]

match : String -> Maybe ApiPath
match = Route.match apiPaths

route : ApiPath -> String
route r =
  case r of
    GetWordsAppended () -> Route.reverse getWordsAppended []

type alias GetWordsAppendedFuncParams
  = (String, String)

type alias GetWordsAppendedFuncResult
  = String

getWordsAppendedFunc: GetWordsAppendedFuncParams -> GetWordsAppendedFuncResult
getWordsAppendedFunc (word1, word2) =
  word1 ++ word2
