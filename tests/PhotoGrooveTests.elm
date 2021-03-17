module PhotoGrooveTests exposing (..)

import Expect exposing (Expectation)
import Json.Decode exposing (decodeString)
import PhotoGroove
import Test exposing (..)


suite : Test
suite =
    test "Title defaults to (untitled)"
        ( \_ ->
            """{"url": "fruits.com", "size":5}"""
                |> decodeString PhotoGroove.photoDecoder
                |> Expect.equal
                    ( Ok { url = "fruits.com", size = 5, title = "(untitled)" } )
        )
