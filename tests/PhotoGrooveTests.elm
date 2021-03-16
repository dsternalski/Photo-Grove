module PhotoGrooveTests exposing (..)

import Expect exposing (Expectation)
import Json.Decode exposing (decodeString)
import PhotoGrove
import Test exposing (..)


suite : Test
suite =
    test "Title defaults to (untitled)"
        ( \_ ->
            "{\"url\": \"fruits.com\", \"size\":5}"
                |> decodeString PhotoGrove.photoDecoder
                |> Expect.equal
                    ( OK { url = "fruits.com", size = 5, title = "" } )
        )
