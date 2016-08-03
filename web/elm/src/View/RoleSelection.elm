module View.RoleSelection exposing (renderRoleSelection)

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
import View.Color exposing (..)

import Msg exposing (..)


renderRoleSelection : Model -> Html Msg
renderRoleSelection {ui,parts} =
  let
      (w,h) = ui.windowSize
      whiteboardButton =
        renderButton Whiteboard w (h*10//100) (w//2) (h*65//100) "#edb" "Whiteboard"
      partButtons =
        parts
        |> List.indexedMap (renderPartButton ui.windowSize parts)
      instruction = renderTextLine (w//2) (h//4) (h//20) "Pick a role"
      children = partButtons ++ [ whiteboardButton, instruction ]
  in
      Svg.svg
        (fullscreenSvgAttributes ui.windowSize)
        children


renderPartButton : (Int,Int) -> List Part -> Int -> Part -> Svg Msg
renderPartButton (w,h) parts index part =
  let
      nParts = List.length parts
      target = PartScreen part
      width = w//nParts
      height = h//10
      x = index * width + width//2
      y = h*45//100
      color = partColor parts part
      text = part.name
  in
      renderButton target width height x y color text


renderButton : Screen -> Int -> Int -> Int -> Int -> String -> String -> Svg Msg
renderButton target width height x y color text =
  let
      background = renderRect (x-width//2) (y-height//2) width height color
      label = renderTextLine x (y+height//10) (height//3) text
  in
      internalLink target [ background, label ]
