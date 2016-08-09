module View.Instructions exposing (renderInstructions)

import Json.Encode
import Html exposing (Html,div,ol,li,h2,button)
import Html.Attributes
import Html.Events
import VirtualDom
import String

import Model exposing (..)
import Model.Ui exposing (..)

import View.Common exposing (..)

import Msg exposing (..)


renderInstructions : Model -> Html Msg
renderInstructions ({ui} as model) =
  let
      (w,h) = ui.windowSize
      heading = h2 [] [ Html.text "Instructions" ] |> centered
      fontSize = (w//16 |> min 24 |> toString) ++ "px"
      backButton =
        Html.button
          [ Html.Attributes.attribute "style" ("font-size: "++fontSize)
          , Html.Events.onClick LeaveRoom ]
          [ Html.text "Back" ]
        |> centered
      steps = renderSteps fontSize
  in
      div
        []
        [ heading, steps, backButton ]


renderSteps : String -> Html Msg
renderSteps fontSize =
  let
      divStyle =
        "width: 100%; max-width: 400px; margin: 25px auto; font-size: "++fontSize
        |> Html.Attributes.attribute "style"
      itemStyle =
        "margin-bottom: "++fontSize
        |> Html.Attributes.attribute "style"
      listItems = List.map (\str -> li [ itemStyle ] [ Html.text str ]) theSteps
  in
      div
        [ divStyle ]
        [ ol [] listItems ]


theSteps : List String
theSteps =
  """Create a room
  Share the room key (e.g. c3k4) with a group of your students
  Press "Whiteboard"
  Let the students pick different roles: subject, verb, ...
  Watch the whiteboard change as students select different words"""
  |> String.split "\n"
