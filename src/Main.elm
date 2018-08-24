module Main exposing (..)

import Browser
import Html exposing (Html, div, p, text, button)
import Html.Events exposing (onClick)
import SharedModels exposing (GMPos)
import GMaps exposing (moveMap, mapMoved)


-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { pos : GMPos
    }



-- UPDATE


type Msg
    = Move Direction
    | MapMoved GMPos


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Move direction ->
            let
                newPos =
                    movePos model.pos direction
            in
                ( { model | pos = newPos }
                , moveMap newPos
                )

        MapMoved newPos ->
            ( { model | pos = newPos }
            , Cmd.none
            )


type Direction
    = North
    | South
    | West
    | East


movePos : GMPos -> Direction -> GMPos
movePos pos direction =
    case direction of
        North ->
            { pos | lat = pos.lat + 1 }

        South ->
            { pos | lat = pos.lat - 1 }

        West ->
            { pos | lng = pos.lng - 1 }

        East ->
            { pos | lng = pos.lng + 1 }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ p [] [ text ("Latitude: " ++ String.fromFloat model.pos.lat) ]
        , p [] [ text ("Longitude: " ++ String.fromFloat model.pos.lng) ]
        , button [ onClick (Move North) ] [ text "North" ]
        , button [ onClick (Move South) ] [ text "South" ]
        , button [ onClick (Move West) ] [ text "West" ]
        , button [ onClick (Move East) ] [ text "East" ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    mapMoved MapMoved



-- INIT


init : () -> ( Model, Cmd Msg )
init _ =
    let
        vienna =
            (GMPos 48.2206636 16.3100206)
    in
        ( Model vienna, moveMap vienna )
