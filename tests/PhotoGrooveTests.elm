module PhotoGrooveTests exposing (..)

import Expect exposing (Expectation)
import Json.Decode as Decode exposing (decodeValue)
import Json.Encode as Encode
import PhotoGroove exposing (Model, Msg(..), Photo, initalModel, update)
import Test exposing (..)
import Fuzz exposing (Fuzzer, int, list, string)


decoderTest : Test
decoderTest =
    fuzz2 string int "Title defaults to (untitled)" <|
        \url size ->
            [ ( "url", Encode.string "fruits.com" )
            , ( "size", Encode.int 5 ) 
            ]
                |> Encode.object
                |> decodeValue PhotoGroove.photoDecoder
                |> Result.map .title
                |> Expect.equal ( Ok "(untitled)" )


sliders : Test
sliders = 
    describe "Slider sets the desired field in the Model"
        [ testSlider "SlidHue" SlidHue .hue
        , testSlider "SlidRipple" SlidRipple .ripple
        , testSlider "SlidNoise" SlidNoise .noise
        ]


testSlider : String -> ( Int -> Msg ) -> ( Model -> Int ) -> Test
testSlider description toMsg amountFromModel = 
    fuzz int description <|
        \amount ->
            initalModel
                |> update ( toMsg amount )
                |> Tuple.first
                |> amountFromModel
                |> Expect.equal amount
        
