module Msg exposing (..)

import Html exposing (Html)

import Model exposing (..)


type Msg = NoOp

subscriptions : Model -> Sub Msg
subscriptions model =
  [] |> Sub.batch
