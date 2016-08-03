module View.RoleSelection exposing (renderRoleSelection)

import Json.Encode
import Html exposing (Html)
import VirtualDom
import String

import Svg exposing (Svg)
import Svg.Attributes

import Model exposing (..)
import Model.Ui exposing (..)

import View.Common exposing (..)
import View.Color exposing (..)

import Msg exposing (..)


renderRoleSelection : Model -> Html Msg
renderRoleSelection {ui} =
  let
      (w,h) = ui.windowSize
      width = w
      height = h//10
      x = w//2
      y = h//2
      text = "Whiteboard"
      color = "#e9b"
      target = Whiteboard
      button = renderButton x y width height color text target
      instruction = renderTextLine x (h//4) (h//20) "Choose a role"
  in
      Svg.svg
        (fullscreenSvgAttributes ui.windowSize)
        [ button, instruction ]


renderButton : Int -> Int -> Int -> Int -> String -> String -> Screen -> Svg Msg
renderButton x y width height color text target =
  let
      background = renderRect (x-width//2) (y-height//2) width height color
      label = renderTextLine x (y+height//6) (height//2) text
  in
      internalLink target [ background, label ]
