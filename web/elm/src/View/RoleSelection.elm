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
import View.Palette exposing (..)

import Msg exposing (..)


renderRoleSelection : Model -> Html Msg
renderRoleSelection {ui,parts,acceptedRoomkey} =
  let
      (w,h) = ui.windowSize
      whiteboardButton =
        renderButton (ChangeScreen Whiteboard) (w//3) (h*10//100) (w//2) (h*90//100) "#aaa" "Whiteboard" True
      partButtons =
        parts
        |> List.indexedMap (renderPartButton ui.windowSize parts)
      roomkey = Maybe.withDefault "" acceptedRoomkey
      roomInfo = renderTextLine (w//2) (h*5//100) (h//30) ("Room "++roomkey)
      instruction = renderTextLine (w//2) (h*26//100) (h*6//100) "Select a role"
      leaveButton = renderLeaveButton ui.windowSize
      bg = renderWindowBackground ui.windowSize "#ddd"
      children = [ bg, whiteboardButton, instruction, roomInfo, leaveButton ] ++ partButtons
  in
      Svg.svg
        (fullscreenSvgAttributes ui.windowSize)
        children


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


renderLeaveButton : (Int,Int) -> Svg Msg
renderLeaveButton (w,h) =
  let
      width = 60
      height = 35
      margin = 10
      x = w-width//2-margin
      y = height//2+margin
      color = "rgba(0,0,0,.15)"
      target = LeaveRoom
  in
      renderButton target width height x y color "exit" True
