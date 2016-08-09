module Update exposing (..)

import Time exposing (Time)
import String
-- import Debug exposing (log)

import Model exposing (..)
import Model.Ui exposing (..)

import Msg exposing (..)

import Join exposing (..)
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

    CreateRoom ->
      let
          ui' = { ui | requestToCreatePending = True }
      in
         ({ model | ui = ui' }, requestToCreate)

    EnterRoomkey userEnteredRoomkey ->
      let
          lowercaseRoomkey = String.toLower userEnteredRoomkey
          effect = if (String.length lowercaseRoomkey) == roomkeyLength then
                      requestToJoin lowercaseRoomkey
                   else
                      Cmd.none
          ui' = { ui | userEnteredRoomkey=lowercaseRoomkey }
      in
         ({ model | ui = ui' }, effect)

    JoinAcceptedOrDenied verdict ->
      case verdict of
        Accepted roomkey ->
          let
              ui' = { ui | screen = RoleSelection
                         , requestToCreatePending = False }
              model' = { model | acceptedRoomkey = Just roomkey
                               , ui = ui' }
          in
             (model', pullData roomkey)

        Denied ->
          let
              ui' = { ui | errorMessage = Just "Room not found"
                         , requestToCreatePending = False }
          in
              ({ model | ui = ui' }, Cmd.none)

    JoinError httpError ->
      let
          message = Just ("Connection error: "++(toString httpError))
          ui' = { ui | errorMessage = message }
      in
         ({ model | ui = ui' }, Cmd.none)

    ChangeScreen screen ->
      let
          ui' = { ui | screen = screen }
          model' = { model | ui = ui' }
          cmd = pullIfJoined model
      in
          (model', cmd)

    ChangePart part ->
      let
          parts' =
            model.parts
            |> List.map (\p -> if p.name==part.name then part else p)
          model' = { model | parts = parts' }
          cmd =
            case model.acceptedRoomkey of
              Just roomkey ->
                updateData roomkey part parts'

              Nothing ->
                Cmd.none
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

    ShowInstructions ->
      let
          ui' = { ui | screen = Instructions }
          model' = { model | ui = ui' }
      in
          (model', Cmd.none)

    LeaveRoom ->
      let
          ui' = { ui | screen = RoomSelection }
          model' = { model | ui = ui'
                           , acceptedRoomkey = Nothing }
      in
          (model', Cmd.none)

    SlowTick _ ->
      let
          cmd = pullIfJoined model
      in
          (model, cmd)

    NoOp ->
      (model, Cmd.none)



pullIfJoined : Model -> Cmd Msg
pullIfJoined {acceptedRoomkey} =
  case acceptedRoomkey of
    Nothing ->
      Cmd.none

    Just roomkey ->
      pullData roomkey
