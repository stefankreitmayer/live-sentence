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
        renderButton (ChangeScreen Whiteboard) (w//3) (h*10//100) (w//2) (h*90//100) "#aaa" "Whiteboard" True
      partButtons =
        parts
        |> List.indexedMap (renderPartButton ui.windowSize parts)
      title = renderTextLine (w//2) (h//5) (h//13) "Live Sentence"
      instruction = renderTextLine (w//2) (h*40//100) (h//24) "Select a role"
      bg = renderWindowBackground ui.windowSize "#ddd"
      children = partButtons ++ [ whiteboardButton, instruction, title ]
  in
      Svg.svg
        (fullscreenSvgAttributes ui.windowSize)
        (bg::children)


renderPartButton : (Int,Int) -> List Part -> Int -> Part -> Svg Msg
renderPartButton (w,h) parts index part =
  let
      nParts = List.length parts
      target = ChangeScreen (PartScreen part.name)
      padding = w//50
      width = w//nParts
      height = h//10
      x = index * width + width//2
      y = h*55//100
      color = partColor parts part
      text = part.name
  in
      renderButton target (width-2*padding) height (x+padding//4) y color text True


renderWindowBackground : (Int,Int) -> String -> Svg Msg
renderWindowBackground (w,h) color =
  renderRect 0 0 w h color
