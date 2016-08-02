module Msg exposing (..)

import Html exposing (Html)
import Window
import Task

import Model exposing (..)
import Model.Ui exposing (..)


type Msg
  = ResizeWindow (Int,Int)
  | ChangeScreen Screen
  | NoOp


subscriptions : Model -> Sub Msg
subscriptions model =
  let
      window = Window.resizes (\{width,height} -> ResizeWindow (width,height))
  in
      [ window ] |> Sub.batch


initialWindowSizeCommand : Cmd Msg
initialWindowSizeCommand =
  Task.perform (\_ -> NoOp) (\{width,height} -> ResizeWindow (width,height)) Window.size
