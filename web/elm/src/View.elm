module View exposing (view)

import Html exposing (Html,div)
import Html.Attributes exposing (class)

import Model exposing (..)
import Model.Ui exposing (..)

import View.RoleSelection exposing (..)
import View.Whiteboard exposing (..)

import Msg exposing (..)


view : Model -> Html Msg
view model =
  case model.ui.screen of
    RoleSelection ->
      renderRoleSelection model

    Whiteboard ->
      renderWhiteboard model
