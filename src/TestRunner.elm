module TestRunner exposing (main)

import Shared.FakeTests exposing (tests)

import ElmTest exposing (..)

allTests : Test
allTests =
  suite "All tests"
    [ tests
    ]

main : Program Never
main =
  runSuiteHtml allTests
