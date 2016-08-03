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

    ChangeScreen screen ->
      let
          ui' = { ui | screen = screen }
          model' = { model | ui = ui' }
      in
          (model', Cmd.none)

    ChangeAtom part atom ->
      let
          sentence' =
            List.map2
              (\a p -> if p==part then atom else a)
              model.sentence
              model.parts
          model' = { model | sentence = sentence' }
      in
          (model', Cmd.none)

    NoOp ->
      (model, Cmd.none)
