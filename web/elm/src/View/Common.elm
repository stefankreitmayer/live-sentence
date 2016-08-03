module View.Common exposing (..)

import Json.Encode
import VirtualDom

import Svg exposing (Svg)
import Svg.Attributes
import Svg.Events

import Model.Ui exposing (..)

import Msg exposing (..)


fullscreenSvgAttributes : (Int,Int) -> List (Svg.Attribute Msg)
fullscreenSvgAttributes (w,h) =
  [ Svg.Attributes.width (toString w)
  , Svg.Attributes.height (toString h)
  , Svg.Attributes.viewBox <| "0 0 " ++ (toString w) ++ " " ++ (toString h)
  , VirtualDom.property "xmlns:xlink" (Json.Encode.string "http://www.w3.org/1999/xlink")
  , Svg.Attributes.version "1.1"
  , Svg.Attributes.style "position: fixed;"
  ]


renderTextLine : Int -> Int -> Int -> String -> Svg Msg
renderTextLine x y fontSize text =
  let
      attributes = [ Svg.Attributes.x <| toString x
                   , Svg.Attributes.y <| toString y
                   , Svg.Attributes.fontSize <| toString fontSize
                   , Svg.Attributes.textAnchor "middle"
                   , Svg.Attributes.fontFamily "monospace"
                   , Svg.Attributes.fill "black"
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


internalLink : Screen -> List (Svg Msg) -> Svg Msg
internalLink screen children =
  Svg.a
    [ Svg.Events.onClick (ChangeScreen screen) ]
    children


renderMenuButton : (Int,Int) -> Svg Msg
renderMenuButton (w,h) =
  let
      width = 80
      height = 65
      margin = 0
      padding = 20
      x = margin
      y = margin
      color = "rgba(0,0,0,.3)"
      transparent = "rgba(0,0,0,0)"
      background = renderRect x y width height transparent
      renderStripe index =
        renderRect (x+padding) (y+index*10+padding) (width-padding*2) 5 color
      stripes = [ 0..2 ] |> List.map renderStripe
      target = RoleSelection
  in
      internalLink target ([ background ] ++ stripes)
