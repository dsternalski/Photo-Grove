module PhotoGrooveTests exposing (..)

import Expect exposing (Expectation)
import Json.Decode exposing (decodeString)
import PhotoGroove
import Test exposing (..)


test : Test
test =
    test "Title defaults to (untitled)" <|
        \_ ->
            """{"url": "fruits.com", "size":5}"""
                |> decodeString PhotoGroove.photoDecoder
                |> Result.map .title
                |> Expect.equal
                    ( Ok "(untitled)" )
        
