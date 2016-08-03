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
  in
      Svg.svg
        (fullscreenSvgAttributes ui.windowSize)
        [ background, menuButton ]


renderPartText : Int -> Int -> Int -> Atom -> Svg Msg
renderPartText h fontSize posX atom =
  let
      x = posX
      y = h//2
  in
      renderTextLine x y fontSize atom


renderPartBackground : Int -> Int -> Int -> String -> Svg Msg
renderPartBackground h x width color =
  renderRect x 0 width h color
