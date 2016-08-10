module View.RoomSelection exposing (renderRoomSelection)

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
      enterRoomKey = renderTextLine (w//2) (h*28//100) (w//12 |> min 24) "Join a room"
      buttonFontSize = (w//12 |> min 24 |> toString) ++ "px"
      createRoomButton =
        Html.button
          [ Html.Events.onClick CreateRoom
          , Html.Attributes.attribute "style"
            <| "position: absolute; top: 65%; left: 50%; transform: translate(-50%); font-size: "++buttonFontSize++"; font-family: monospace; padding: 10px 20px; background: #59e; color: #222;"
          ]
          [ Html.text "Make a room" ]
        |> centered
      instructionsButton =
        Html.button
          [ Html.Events.onClick ShowInstructions
          , Html.Attributes.attribute "style"
            <| "position: absolute; top: 88%; left: 50%; transform: translate(-50%); font-size: "++buttonFontSize++"; font-family: monospace;"
          ]
          [ Html.text "Instructions" ]
        |> centered
      svgChildren =
          [ bg, title, enterRoomKey ]
      svg =
        Svg.svg
          (fullscreenSvgAttributes ui.windowSize)
          svgChildren
  in
      div
        []
        [ svg, textInput, instructionsButton, createRoomButton ]


textInput : Html Msg
textInput =
  let
      style =
        "width: 100px; position: absolute; top: 35%; left: 50%; transform: translate(-50%); padding: 10px 0; font-size: 2em; text-align: center;"
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


renderTitle : (Int,Int) -> Svg Msg
renderTitle (w,h) =
  renderTextLine (w//2) (h//10) (w*12//100) "Live Sentence"
