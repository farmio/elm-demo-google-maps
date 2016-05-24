import Html exposing (Html, div, p, text, button)
import Html.Events exposing (onClick)
import Html.App

import SharedModels exposing (GMPos)
import GMaps exposing (moveMap, mapMoved)


-- MAIN

main : Program Never
main = Html.App.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

-- MODEL

type alias Model =
  { pos : GMPos
  }


-- UPDATE

type Msg
  = North
  | South
  | West
  | East
  | MapMoved GMPos

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    North ->
      let
        newPos = GMPos (model.pos.lat + 1) model.pos.lng
      in
        ( { model | pos = newPos }
        , moveMap newPos
        )
    South ->
      let
        newPos = GMPos (model.pos.lat - 1) model.pos.lng
      in
        ( { model | pos = newPos }
        , moveMap newPos
        )
    West ->
      let
        newPos = GMPos model.pos.lat (model.pos.lng - 1)
      in
        ( { model | pos = newPos }
        , moveMap newPos
        )
    East ->
      let
        newPos = GMPos model.pos.lat (model.pos.lng + 1)
      in
        ( { model | pos = newPos }
        , moveMap newPos
        )
    MapMoved newPos ->
      ( { model | pos = newPos }
      , Cmd.none
      )


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ p [] [ text ("Latitude: " ++ toString model.pos.lat)]
    , p [] [text ("Longitude: " ++ toString model.pos.lng)]
    , button [ onClick North ] [ text "North" ]
    , button [ onClick South ] [ text "South" ]
    , button [ onClick West ] [ text "West" ]
    , button [ onClick East ] [ text "East" ]
    ]


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  mapMoved MapMoved


-- INIT

init : (Model, Cmd Msg)
init =
  let
    vienna = ( GMPos 48.2206636 16.3100206 )
  in
    ( Model vienna, moveMap vienna )
