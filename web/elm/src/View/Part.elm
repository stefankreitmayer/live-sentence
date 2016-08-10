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
      ws = w |> toString
      hs = h |> toString
      color = partColor parts part
      menuButton = menuButtonHtml
      atomButtons =
        part.atoms
        |> List.indexedMap (renderAtomButton ui.windowSize part part.atoms)
      background =
        div
          [ Html.Attributes.attribute "style" ("position: fixed; top: 0; height: "++hs++"px; width: "++ws++"px; background: "++color++"; z-index: -1000;") ]
          []
  in
      div
      [ Html.Attributes.attribute "style"
        <| "height: 100%; margin: 0"
      ]
      ( [ menuButton, background ] ++ atomButtons)


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
