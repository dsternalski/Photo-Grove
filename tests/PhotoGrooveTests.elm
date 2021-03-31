module PhotoGrooveTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Html.Attributes as Attr exposing (src)
import Json.Decode as Decode exposing (decodeValue)
import Json.Encode as Encode
import PhotoGroove exposing (Model, Msg(..), Photo, initalModel, update)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, tag, attribute)


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
        

noPhotosNoThumbnails : Test
noPhotosNoThumbnails = 
    test "No thumbnails render when there are no photos to render." <|
        \_ -> 
            initalModel
                |> PhotoGroove.view
                |> Query.fromHtml
                |> Query.findAll [ tag "img" ]
                |> Query.count ( Expect.equal 0 )


thumbnailsRendered : String -> Query.Single msg -> Expectation
thumbnailsRendered url query = 
    query
        |> Query.findAll [ tag "img", attribute, ( Attr.src ( urlPrefix ++ url ) ) ]
        |> Query.count ( Expect.atLeast 1 )


photoFromUrl : String -> Photo
photoFromUrl url = 
    { url = url, size = 0, title = "" }