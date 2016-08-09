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


renderInstructions : Ui -> Html Msg
renderInstructions {windowSize,instructionsVisible,instructionsButtonEverPressed} =
  let
      (w,h) = windowSize
      heading = h2 [] [ Html.text "Instructions" ] |> centered
      fontSize = (w//16 |> min 24 |> toString) ++ "px"
      marginBetweenSteps = ((w//16 |> min 24) * 2//3 |> toString) ++ "px"
      posY = (if instructionsVisible then 0 else h) |> toString
      backButton =
        if instructionsVisible then
          [ Html.button
              [ Html.Attributes.attribute "style" ("position: absolute; top: 0; width: 60px; font-size: 42px;")
              , Html.Events.onClick LeaveRoom ]
              [ Html.text "×" ]
          ]
        else
          []
      steps = renderSteps fontSize marginBetweenSteps
  in
      div
        [ Html.Attributes.attribute "style" ("visibility: "++(if instructionsButtonEverPressed then "visible" else "hidden")++"; position: fixed; top: "++posY++"px; height: "++(toString h)++"px; width: "++(toString w)++"px; border-top: 1px solid #aaa; background: #eee; transition: top 1s") ]
        ([ heading, steps ] ++ backButton)


renderSteps : String -> String -> Html Msg
renderSteps fontSize marginBetweenSteps =
  let
      divStyle =
        "width: 100%; max-width: 400px; margin: 25px auto; font-size: "++fontSize
        |> Html.Attributes.attribute "style"
      itemStyle =
        "margin-top: "++marginBetweenSteps
        |> Html.Attributes.attribute "style"
      listItems = List.map (\str -> li [ itemStyle ] [ Html.text str ]) theSteps
  in
      div
        [ divStyle ]
        [ ol [] listItems ]


theSteps : List String
theSteps =
  """Click "Create a new room"
  Find the room key at the top, e.g. 5cy7
  Invite a group of students to join the room by typing this key
  Click "Whiteboard"
  Let the students pick different roles: subject, verb, ...
  Watch the whiteboard display change as students choose different words"""
  |> String.split "\n"
