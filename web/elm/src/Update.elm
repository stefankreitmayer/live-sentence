module Update exposing (..)

import Time exposing (Time)
import String
-- import Debug exposing (log)

import Model exposing (..)
import Model.Ui exposing (..)
import Msg exposing (..)

import Poll exposing (pullData,updateData)


update : Msg -> Model -> (Model, Cmd Msg)
update action ({ui} as model) =
  case action of
    ResizeWindow dimensions ->
      let
          ui' = { ui | windowSize = dimensions }
          model' = { model | ui = ui' }
      in
          (model', Cmd.none)

    EnterKey key ->
      let
          screen =
            if String.length key == 4 then
                RoleSelection
            else
                ui.screen
          ui' = { ui | screen = screen }
          model' =
            { model | ui = ui'
            , roomKey = Just key }
      in
          (model', Cmd.none)


    ChangeScreen screen ->
      let
          ui' = { ui | screen = screen }
          model' = { model | ui = ui' }
          cmd = if screen==Whiteboard then pullData else Cmd.none
      in
          (model', cmd)

    ChangePart part ->
      let
          parts' =
            model.parts
            |> List.map (\p -> if p.name==part.name then part else p)
          model' = { model | parts = parts' }
          cmd = updateData part parts'
      in
          (model', cmd)

    PollSuccess sentence ->
      let
          parts' =
            List.map2
              (\part atom -> { part | chosenAtom = atom })
              model.parts
              sentence
          model' = { model | parts = parts'
                           , connectionStatus = Connected }
      in
          (model', Cmd.none)

    PollFailure error ->
      let
          model' = { model | connectionStatus = ConnectionError (toString error) }
      in
          (model', Cmd.none)

    SlowTick _ ->
      (model, pullData)

    NoOp ->
      (model, Cmd.none)
