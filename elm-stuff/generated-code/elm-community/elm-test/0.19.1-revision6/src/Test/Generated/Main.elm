module Test.Generated.Main exposing (main)

import PhotoGrooveTests

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    Test.Runner.Node.run
        { runs = 100
        , report = ConsoleReport UseColor
        , seed = 133859671954683
        , processes = 12
        , globs =
            []
        , paths =
            [ "D:\\ELM\\Photo-Groove\\tests\\PhotoGrooveTests.elm"
            ]
        }
        [ ( "PhotoGrooveTests"
          , [ Test.Runner.Node.check PhotoGrooveTests.suite
            ]
          )
        ]