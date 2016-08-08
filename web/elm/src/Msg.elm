module Msg exposing (..)

import Html exposing (Html)
import Window
import Task
import Http
import Time exposing (Time,every,second)

import Model exposing (..)
import Model.Ui exposing (..)
import Model.Part exposing (..)


type Msg
  = ResizeWindow (Int,Int)
  | EnterKey String
  | ChangeScreen Screen
  | ChangePart Part
  | PollSuccess (List String)
  | PollFailure Http.Error
  | SlowTick Time
  | NoOp


subscriptions : Model -> Sub Msg
subscriptions model =
  let
      window = Window.resizes (\{width,height} -> ResizeWindow (width,height))
      periodicPoll = every (2*second) SlowTick
  in
      [ window, periodicPoll ] |> Sub.batch


initialWindowSize : Cmd Msg
initialWindowSize =
  Task.perform (\_ -> NoOp) (\{width,height} -> ResizeWindow (width,height)) Window.size
