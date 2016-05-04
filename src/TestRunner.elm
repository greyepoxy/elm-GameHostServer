module TestRunner where

import Shared.FakeTests exposing (tests)

import ElmTest exposing (..)
import Graphics.Element exposing (Element)

allTests : Test
allTests =
  suite "All tests"
    [ tests
    ]

main : Element
main =
  elementRunner allTests
