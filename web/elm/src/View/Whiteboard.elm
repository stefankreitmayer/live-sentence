module View.Whiteboard exposing (renderWhiteboard)

import Json.Encode
import Html exposing (Html)
import VirtualDom
import String

import Svg exposing (Svg)
import Svg.Attributes exposing (..)

import Model exposing (..)
import Model.Ui exposing (..)

import View.Color exposing (..)

import Msg exposing (..)


renderWhiteboard : Model -> Html Msg
renderWhiteboard {ui,sentence} =
  let
      parts = renderParts ui.windowSize sentence
  in
      Svg.svg
        (svgAttributes ui.windowSize)
        [ parts ]


svgAttributes : (Int,Int) -> List (Svg.Attribute Msg)
svgAttributes (w,h) =
  [ Svg.Attributes.width (toString w)
  , Svg.Attributes.height (toString h)
  , Svg.Attributes.viewBox <| "0 0 " ++ (toString w) ++ " " ++ (toString h)
  , VirtualDom.property "xmlns:xlink" (Json.Encode.string "http://www.w3.org/1999/xlink")
  , Svg.Attributes.version "1.1"
  , Svg.Attributes.style "position: fixed;"
  ]


renderParts : (Int,Int) -> List Atom -> Svg Msg
renderParts (w,h) atoms =
  let
      lengths = atoms |> List.map String.length
      totalLength = List.sum lengths
      pixelsPerCharacter = (toFloat w) / (toFloat totalLength)
      fontSize = pixelsPerCharacter * 1.3 |> floor
      partWidth atom =
        (String.length atom |> toFloat) * pixelsPerCharacter |> floor
      widths =
        atoms
        |> List.map partWidth
      leftPositions = widths |> List.scanl (+) 0
      textPositions =
        List.map2
          (\position width -> position + width//2)
          leftPositions
          widths
      texts =
        List.map2 (renderPartText h fontSize) textPositions atoms
      backgrounds =
        List.map3 (renderPartBackground h) leftPositions widths partColors
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
      renderTextLine x y fontSize atom


renderTextLine : Int -> Int -> Int -> String -> Svg Msg
renderTextLine x y fontSize content =
  let
      attributes = [ Svg.Attributes.x <| toString x
                   , Svg.Attributes.y <| toString y
                   , Svg.Attributes.fontSize <| toString fontSize
                   , Svg.Attributes.textAnchor "middle"
                   , Svg.Attributes.fontFamily "monospace"
                   , Svg.Attributes.fill "black"
                   ]
  in
      Svg.text' attributes [ Svg.text content ]


renderPartBackground : Int -> Int -> Int -> String -> Svg Msg
renderPartBackground height x width color =
  Svg.rect
    [ Svg.Attributes.x (toString x)
    , Svg.Attributes.y "0"
    , Svg.Attributes.width (toString width)
    , Svg.Attributes.height (toString height)
    , Svg.Attributes.fill color ]
    []
