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
import View.Palette exposing (..)

import Msg exposing (..)


renderRoomSelection : Model -> Html Msg
renderRoomSelection {ui,parts} =
  let
      (w,h) = ui.windowSize
      bg = renderWindowBackground ui.windowSize "#ddd"
      title = renderTitle ui.windowSize
      typeRoomKey = renderTextLine (w//2) (h*28//100) (w//12 |> min 24) "middle" "Join a room"
      buttonFontSize = (w//12 |> min 24 |> toString) ++ "px"
      createRoomButton =
        Html.button
          [ Html.Events.onClick CreateRoom
          , Html.Attributes.attribute "style"
            <| "position: absolute; top: 65%; left: 50%; transform: translate(-50%); font-size: "++buttonFontSize++"; font-family: monospace; padding: 10px 20px; background: "++happyBlue++"; color: #222; border: none"
          ]
          [ Html.text "Make a room" ]
        |> centered
      instructionsButton =
        Html.button
          [ Html.Events.onClick ShowInstructions
          , Html.Attributes.attribute "style"
            <| "position: absolute; top: 88%; left: 50%; transform: translate(-50%); font-size: "++buttonFontSize++"; font-family: monospace; border: none"
          ]
          [ Html.text "Instructions" ]
        |> centered
      svgChildren =
          [ bg, title, typeRoomKey ]
      svg =
        Svg.svg
          (fullscreenSvgAttributes ui.windowSize)
          svgChildren
      joinWidget =
        renderJoinWidget
          ui.windowSize
          ui.roomNotFoundMessageVisible
          ui.requestToJoinPending
  in
      div
        []
        [ svg, joinWidget, instructionsButton, createRoomButton ]


renderJoinWidget : (Int,Int) -> Bool -> Bool -> Html Msg
renderJoinWidget (w,h) roomNotFoundMessageVisible requestPending =
  let
      posX = w//2 - 100 |> toString
      posY = h*37//100 |> toString
      textInput = renderTextInput
      notFound = renderNotFoundMessage roomNotFoundMessageVisible
      enterbutton = renderEnterButton requestPending
      innerDiv =
        div
          [ Html.Attributes.attribute "style" "position: relative" ]
          [ notFound, textInput, enterbutton ]
  in
      div
        [ Html.Attributes.attribute "style" ("position: absolute; top: "++posY++"px; left: "++posX++"px") ]
        [ innerDiv ]


renderTextInput : Html Msg
renderTextInput =
  let
      style =
        Html.Attributes.attribute "style"
        "width: 100px; position: absolute; top: 0; left: 0; padding: 2px 0; font-family: monospace; font-size: 2em; text-align: center;"
  in
      Html.input
        [ Html.Attributes.placeholder "Key"
        , Html.Events.onInput (\v -> TypeRoomkey v)
        , Html.Attributes.autofocus True
        , Html.Attributes.autocomplete False
        , Html.Attributes.spellcheck False
        , Html.Attributes.maxlength 5
        , style ]
        []


renderEnterButton : Bool -> Html Msg
renderEnterButton requestPending =
  let
      color = if requestPending then "#6ce" else happyBlue
      style =
        Html.Attributes.attribute "style"
        ("width: 100px; position: absolute; top: 0; left: 100px; padding: 2px 0; font-family: monospace; font-size: 2em; text-align: center; background: "++color++"; border: none")
      clickHandler =
        if requestPending then
            []
        else
            [ Html.Events.onClick PressEnterButton ]
      attributes = style :: clickHandler
  in
      Html.button
        attributes
        [ Html.text "Enter" ]


renderNotFoundMessage : Bool -> Html Msg
renderNotFoundMessage visible =
  let
      height = 24
      posY = toString <| if visible then -height else 2
      style =
        "position: absolute; top: "++posY++"px; left: 0; width: 200px; height: "++(height |> toString)++"px; padding: 0; font-family: monospace; font-size: 14px; text-align: center; background: "++happyRed++"; transition: top .7s"
        |> Html.Attributes.attribute "style"
  in
      div
        [ style ]
        -- [ Html.text "Please type a valid key"]
        -- [ Html.text "No room with this key"]
        [ Html.text "This room doesn't exist"]


renderTitle : (Int,Int) -> Svg Msg
renderTitle (w,h) =
  renderTextLine (w//2) (h//10) (w*12//100) "middle" "Live Sentence"
