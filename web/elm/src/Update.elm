module Update exposing (..)

import Model exposing (..)
import Msg exposing (..)


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  (model, Cmd.none)
