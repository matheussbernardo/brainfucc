module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Generator exposing (generate)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Parser exposing (parse)


main =
    Browser.sandbox
        { view = view
        , update = update
        , init = init
        }



-- MODEL --------------------------------------------------


type alias Model =
    { input : String, out : String }


init : Model
init =
    { input = "", out = "" }



-- MESSAGES ----------------------------------------------


type Msg
    = Compile String
    | Replace String


update : Msg -> Model -> Model
update msg m =
    case msg of
        Compile st ->
            { m | out = compileCode st }

        Replace st ->
            { m | input = st }



-- VIEW --------------------------------------------------


view : Model -> Html Msg
view m =
    div []
        [ code [] [ pre [] [ text m.out ] ]
        , input [ placeholder "Type here", onInput Replace ] []
        , button [ onClick (Compile m.input) ] [ text "What's your name?" ]
        ]


compileCode : String -> String
compileCode st =
    st |> parse |> generate |> String.concat
