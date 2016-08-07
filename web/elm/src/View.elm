module View exposing (view)

import Html exposing (Html,div)
import Html.Attributes exposing (class)

import Model exposing (..)
import Model.Ui exposing (..)
import Model.Part exposing (..)

import View.RoleSelection exposing (..)
import View.Whiteboard exposing (..)
import View.Part exposing (..)

import Msg exposing (..)


view : Model -> Html Msg
view model =
  let
      fn =
        case model.ui.screen of
          RoleSelection ->
            renderRoleSelection

          Whiteboard ->
            renderWhiteboard

          PartScreen partName ->
            case (findPart model.parts partName) of
              Just part ->
                renderPartScreen part

              Nothing ->
                renderRoleSelection
  in
      fn model


renderUserMessage : String -> Html Msg
renderUserMessage message =
  div
    [ class "elm-user-message" ]
    [ Html.text message ]


  -- case connectionStatus of
  --     Connecting ->
  --       renderUserMessage "Connecting..."

  --     Connected ->
  --       renderPartScreen part

  --     ConnectionError message ->
  --       renderUserMessage ("Oops! Connection error: "++message)
