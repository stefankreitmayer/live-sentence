module View.Whiteboard exposing (renderWhiteboard)

import Html exposing (Html,div)
import String

import Svg exposing (Svg)
import Svg.Attributes

import Model exposing (..)
import Model.Ui exposing (..)
import Model.Part exposing (..)

import View.Common exposing (..)
import View.Palette exposing (..)

import Msg exposing (..)


renderWhiteboard : Model -> Html Msg
renderWhiteboard {ui,parts} =
  let
      partAreas = renderParts ui.windowSize (sentence parts)
      menuButton = menuButtonHtml True
      svg = Svg.svg (fullscreenSvgAttributes ui.windowSize) [ partAreas ]
  in
      div [] [ menuButton, svg ]


renderParts : (Int,Int) -> List Atom -> Svg Msg
renderParts (w,h) atoms =
  let
      lengths = atoms
      |> List.map String.length
      |> List.map ((+) padding)
      totalLength = List.sum lengths
      pixelsPerCharacter = (toFloat w) / (toFloat totalLength)
      fontSize = pixelsPerCharacter * 1.6 |> floor
      widths =
        lengths
        |> List.map (\l -> (toFloat l) * pixelsPerCharacter |> ceiling)
      leftPositions = widths |> List.scanl (+) 0
      textPositions =
        List.map2
          (\position width -> position + width//2)
          leftPositions
          widths
      texts =
        List.map2 (renderPartText h fontSize) textPositions atoms
      backgrounds =
        List.map3 (renderPartBackground h) leftPositions widths palette
  in
      Svg.g
        []
        (backgrounds ++ texts)


renderPartText : Int -> Int -> Int -> Atom -> Svg Msg
renderPartText h fontSize posX atom =
  let
      x = posX
      y = h//2
  in
      renderTextLine x y fontSize "middle" atom


renderPartBackground : Int -> Int -> Int -> String -> Svg Msg
renderPartBackground h x width color =
  renderRect x 0 width h color


padding : Int
padding = 2
