module View.Common exposing (..)

import Html exposing (Html,div)
import Html.Attributes
import Html.Events
import Json.Encode
import VirtualDom
import String

import Svg exposing (Svg)
import Svg.Attributes
import Svg.Events

import Model.Ui exposing (..)

import Msg exposing (..)


basicSvg : Int -> Int -> List (Svg.Attribute Msg) -> List (Svg Msg) -> Svg Msg
basicSvg width height additionalAttributes children =
  let
      w = width |> toString
      h = height |> toString
      attributes =
        [ Svg.Attributes.width w
        , Svg.Attributes.height h
        , Svg.Attributes.viewBox <| "0 0 " ++ w ++ " " ++ h
        , VirtualDom.property "xmlns:xlink" (Json.Encode.string "http://www.w3.org/1999/xlink")
        , Svg.Attributes.version "1.1"
        ] ++ additionalAttributes
  in
      Svg.svg attributes children


fullscreenSvgAttributes : (Int,Int) -> List (Svg.Attribute Msg)
fullscreenSvgAttributes (w,h) =
  [ Svg.Attributes.width (toString w)
  , Svg.Attributes.height (toString h)
  , Svg.Attributes.viewBox <| "0 0 " ++ (toString w) ++ " " ++ (toString h)
  , VirtualDom.property "xmlns:xlink" (Json.Encode.string "http://www.w3.org/1999/xlink")
  , Svg.Attributes.version "1.1"
  , Svg.Attributes.style "position: fixed;"
  ]


renderTextLine : Int -> Int -> Int -> String -> String -> Svg Msg
renderTextLine x y fontSize anchor text =
  let
      attributes = [ Svg.Attributes.x <| toString x
                   , Svg.Attributes.y <| toString y
                   , Svg.Attributes.fontSize <| toString fontSize
                   , Svg.Attributes.textDecoration "none"
                   , Svg.Attributes.textAnchor anchor
                   , Svg.Attributes.fontFamily "monospace"
                   , Svg.Attributes.fill "#222"
                   , Svg.Attributes.style "pointer-events: none"
                   ]
  in
      Svg.text' attributes [ Svg.text text ]


renderRect : Int -> Int -> Int -> Int -> String -> Svg Msg
renderRect x y width height color =
  Svg.rect
    [ Svg.Attributes.x (toString x)
    , Svg.Attributes.y (toString y)
    , Svg.Attributes.width (toString width)
    , Svg.Attributes.height (toString height)
    , Svg.Attributes.fill color ]
    []


internalLink : Msg -> List (Svg Msg) -> Svg Msg
internalLink msg children =
  Svg.a
    [ Svg.Events.onClick msg ]
    children


menuButtonHtml : Bool -> Html Msg
menuButtonHtml positionFixed =
  let
      width = 80
      height = 60
      padding = 20
      color = "rgba(0,0,0,.3)"
      renderStripe index =
        renderRect padding (index*10+padding) (width-padding*2) 5 color
      stripes = [ 0..2 ] |> List.map renderStripe
      svg =
        basicSvg
          width
          height
          []
          stripes
      position =
        if positionFixed then [ ("position","fixed"), ("z-index","2") ] else []
      style =
          [ ("background", "transparent")
          , ("border", "none") ]
          ++ position
  in
      Html.button
        [ Html.Events.onClick (ChangeScreen RoleSelection)
        , Html.Attributes.style style
        ]
        [ svg ]


renderButton : Msg -> Int -> Int -> Int -> Int -> String -> String -> Bool -> Svg Msg
renderButton target width height x y color text enabled =
  let
      background = renderRect (x-width//2) (y-height*58//100) width height color
      fontSize = width * 3 // 2 // (String.length text) |> min (height*90//100)
      label = renderTextLine x (y+fontSize//5) fontSize "middle" text
      children =
        if enabled then
            [ internalLink target [ background ], label ]
        else
            [ background, label ]
  in
      Svg.g [] children


renderWindowBackground : (Int,Int) -> String -> Svg Msg
renderWindowBackground (w,h) color =
  renderRect 0 0 w h color


centered : Html Msg -> Html Msg
centered element =
  div
    [ Html.Attributes.attribute "style" "text-align: center" ]
    [ element ]
