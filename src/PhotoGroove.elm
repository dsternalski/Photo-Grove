module PhotoGroove exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)

urlPrefix = 
    "http://elm-in-action.com/"

view model = 
    div [class "content"]
        [h1 [] [text "Photo Groove"]
        , div [id "thumbnails"] 
            (List.map 
                -- \photo is the name of the annoymous function and uses that SAME name at the end of the function call. Think of photo (at the begining and end) in the same way as a 'value', e.g. var a = 0 in a for loop.
                (\photo -> viewThumbnail model.selectedUrl photo)
                --  The model in this instance is refering to the initalModel as this is what is called in main.
                model.photos 
            )
        , img 
            [class "large"
            , src (urlPrefix ++ "large/" ++ model.selectedUrl)
            ]
            []
        ]

viewThumbnail selectedUrl thumb = 
    img 
        [src (urlPrefix ++ thumb.url)
        , classList [("selected", selectedUrl == thumb.url)]
        ] 
        []

initalModel = 
    {photos = 
        [{url = "1.jpeg"}
        ,{url = "2.jpeg"}
        ,{url = "3.jpeg"}
        ]
    , selectedUrl = "1.jpeg"
    }

main = 
    view initalModel