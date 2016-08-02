module Update exposing (..)

import Model exposing (..)
import Msg exposing (..)


update : Msg -> Model -> (Model, Cmd Msg)
update action ({ui} as model) =
  case action of
    ResizeWindow dimensions ->
      let
          ui' = { ui | windowSize = dimensions }
          model' = { model | ui = ui' }
      in
         (model', Cmd.none)

    NoOp ->
      (model, Cmd.none)
