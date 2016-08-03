module View.Part exposing (renderPartScreen)

import Html exposing (Html)
import String

import Svg exposing (Svg)
import Svg.Attributes

import Model exposing (..)
import Model.Ui exposing (..)
import Model.Part exposing (..)

import View.Common exposing (..)
import View.Color exposing (..)

import Msg exposing (..)


renderPartScreen : Part -> Model -> Html Msg
renderPartScreen part {parts,ui} =
  let
      (w,h) = ui.windowSize
      color = partColor parts part
      menuButton = renderMenuButton ui.windowSize
      background = renderPartBackground h 0 w color
      atomButtons =
        part.atoms
        |> List.indexedMap (renderAtomButton ui.windowSize part part.atoms)
  in
      Svg.svg
        (fullscreenSvgAttributes ui.windowSize)
        ([ background, menuButton ] ++ atomButtons)


renderPartBackground : Int -> Int -> Int -> String -> Svg Msg
renderPartBackground h x width color =
  renderRect x 0 width h color


renderAtomButton : (Int,Int) -> Part -> List Atom -> Int -> Atom -> Svg Msg
renderAtomButton (w,h) part atoms index atom =
  let
      target = ChangeAtom part atom
      width = w
      height = h//8
      x = w//2
      y = height * index + h//6
      color = "rgba(0,0,0,.1)"
      text = atom
  in
      renderButton target width height x y color text
