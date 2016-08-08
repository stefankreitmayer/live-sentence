module View.RoomSelection exposing (renderRoomSelection)

import Json.Encode
import Html exposing (Html)
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
      instruction = renderTextLine (w//2) (h*40//100) (h//24) "Enter the room key"
      bg = renderWindowBackground ui.windowSize "#ddd"
      children = [ bg, instruction, title ]
  in
      Svg.svg
        (fullscreenSvgAttributes ui.windowSize)
        children
