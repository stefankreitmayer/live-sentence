module View exposing (view)

import Html exposing (Html,div)
import Html.Attributes exposing (class)

import Model exposing (..)
import Model.Ui exposing (..)
import Model.Part exposing (..)

import View.RoomSelection exposing (..)
import View.RoleSelection exposing (..)
import View.Whiteboard exposing (..)
import View.Instructions exposing (..)
import View.Part exposing (..)

import Msg exposing (..)


view : Model -> Html Msg
view ({ui,parts} as model) =
  let
      fn =
        case ui.screen of
          Instructions ->
            renderInstructions

          RoomSelection ->
            renderRoomSelection

          RoleSelection ->
            renderRoleSelection

          Whiteboard ->
            renderWhiteboard

          PartScreen partName ->
            case (findPart parts partName) of
              Just part ->
                renderPartScreen part

              Nothing ->
                renderRoleSelection
  in
      fn model
