module View.Part exposing (renderPartScreen)

import Html exposing (Html,div)
import Html.Attributes
import Html.Events

import Json.Encode
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


renderPartScreen : Part -> Model -> Html Msg
renderPartScreen part {parts,ui} =
  let
      (w,h) = ui.windowSize
      color = partColor parts part
      menuButton = renderMenuButton ui.windowSize
      atomButtons =
        part.atoms
        |> List.indexedMap (renderAtomButton ui.windowSize part part.atoms)
      svg =
        let
            width = w |> toString
            height = h//8 |> toString
        in
            Svg.svg
              [ Svg.Attributes.width width
              , Svg.Attributes.height height
              , Svg.Attributes.viewBox <| "0 0 " ++ width ++ " " ++ height
              , VirtualDom.property "xmlns:xlink" (Json.Encode.string "http://www.w3.org/1999/xlink")
              , Svg.Attributes.version "1.1"
              ]
              [ menuButton ]
  in
      div
      [ Html.Attributes.attribute "style"
        <| "height: 100%; margin: 0; background: "++color
      ]
      ([ svg ] ++ atomButtons)


renderAtomButton : (Int,Int) -> Part -> List Atom -> Int -> Atom -> Html Msg
renderAtomButton (w,h) part atoms index atom =
  let
      target = ChangePart { part | chosenAtom = atom }
      width = w
      height = h//8
      x = w//2
      y = height * index + h*20//100
      clickable = not (atom == part.chosenAtom)
      color = "rgba(0,0,0," ++ (if clickable then "0" else ".15") ++ ")"
      fontSize =
        w * 3//2 // (String.length text)
        |> min 80
        |> toString
      text = atom
  in
        Html.button
          [ Html.Events.onClick target
          , Html.Attributes.attribute "style"
            <| "width: 100%; min-height: 80px; font-size: "++fontSize++"px; font-family: monospace; margin: 0; padding: 0; background: "++color++"; border: none"
          ]
          [ Html.text atom]
        |> centered
