module View.RoomSelection exposing (renderRoomSelection)

import Json.Encode
import Html exposing (Html,div)
import Html.Attributes
import Html.Events
import VirtualDom
import String

import Svg exposing (Svg)
import Svg.Attributes

import Model exposing (..)
import Model.Ui exposing (..)
import Model.Part exposing (..)

import View.Common exposing (..)

import Msg exposing (..)


renderRoomSelection : Model -> Html Msg
renderRoomSelection {ui,parts} =
  let
      (w,h) = ui.windowSize
      bg = renderWindowBackground ui.windowSize "#ddd"
      title = renderTitle ui.windowSize
      enterRoomKey = renderTextLine (w//2) (h*36//100) (h//20) "Join a room"
      or = renderTextLine (w//2) (h*63//100) (h//24) "or"
      createRoomButton =
        if ui.requestToCreatePending then
            []
        else
            [ renderButton
                CreateRoom
                (w*84//100 |> min 400)
                (w//10 |> min 50)
                (w//2)
                (h*73//100)
                "#6ae"
                "Create a new room"
                True
            ]
      fontSize = (w//16 |> min 24 |> toString) ++ "px"
      instructionsButton =
        Html.button
          [ Html.Events.onClick ShowInstructions
          , "position: absolute; top: 88%; left: 50%; transform: translate(-50%); font-size: "++fontSize++";"
            |> Html.Attributes.attribute "style" ]
          [ Html.text "Instructions" ]
        |> centered
      svgChildren =
          [ bg, title, enterRoomKey, or ] ++ createRoomButton
      svg =
        Svg.svg
          (fullscreenSvgAttributes ui.windowSize)
          svgChildren
  in
      div
        []
        [ svg, textInput, instructionsButton ]


textInput : Html Msg
textInput =
  let
      style =
        "width: 100px; position: absolute; top: 42%; left: 50%; transform: translate(-50%); padding: 10px 0; font-size: 2em; text-align: center;"
        |> Html.Attributes.attribute "style"
  in
      Html.input
        [ Html.Attributes.placeholder "Key"
        , Html.Events.onInput (\v -> EnterRoomkey v)
        , Html.Attributes.autofocus True
        , Html.Attributes.autocomplete False
        , Html.Attributes.spellcheck False
        , Html.Attributes.maxlength 5
        , style ]
        []
