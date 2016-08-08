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
      title = renderTitle ui.windowSize
      instruction = renderTextLine (w//2) (h*40//100) (h//24) "Enter room key"
      teacher = renderTextLine (w//2) (h*90//100) (h//30) "Teacher Login"
      bg = renderWindowBackground ui.windowSize "#ddd"
      svgComponents =
        Svg.svg
          (fullscreenSvgAttributes ui.windowSize)
          [ bg, instruction, title, teacher ]
  in
      div
        []
        [ svgComponents, textInput ]


textInput : Html Msg
textInput =
  let
      style =
        "width: 200px; height: 35px; position: absolute; top: 50%; left: 50%; transform: translate(-50%); padding: 10px 0; font-size: 2em; text-align: center;"
        |> Html.Attributes.attribute "style"
  in
      Html.input
        [ Html.Attributes.placeholder "Key"
        , Html.Events.onInput (\v -> EnterKey v)
        , Html.Attributes.autofocus True
        , Html.Attributes.autocomplete False
        , Html.Attributes.spellcheck False
        , Html.Attributes.maxlength 5
        , style ]
        []
