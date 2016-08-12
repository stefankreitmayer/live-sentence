module View.RoleSelection exposing (renderRoleSelection)

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
      roomInfo = renderRoomInfo h roomkey
      instruction = renderTextLine (w//2) (h*30//100) (h*6//100) "middle" "Pick a role"
      leaveButton = renderLeaveButton ui.windowSize
      bg = renderWindowBackground ui.windowSize "#ddd"
      svg =
        Svg.svg
          (fullscreenSvgAttributes ui.windowSize)
          ([ bg, whiteboardButton, instruction ] ++ partButtons)
  in
     div
       []
       [ svg, leaveButton, roomInfo ]


renderRoomInfo : Int -> String -> Html Msg
renderRoomInfo h roomkey =
  div
    [ Html.Attributes.attribute "style" ("font-family: monospace; font-size: 24px; position: fixed; top: 2px; left: 7px;") ]
    [ Html.text roomkey ]


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
      Html.button
        [ Html.Events.onClick LeaveRoom
        , Html.Attributes.attribute "style"
          <| "position: absolute; top: 5px; right: 5px; font-size: 16px; font-family: monospace; padding: 4px 10px; background: #eee; color: #222; border: none"
        ]
        [ Html.text "Leave this room" ]
      |> centered
