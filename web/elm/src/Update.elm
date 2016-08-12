module Update exposing (..)

import Time exposing (Time)
import String
-- import Debug exposing (log)

import Model exposing (..)
import Model.Ui exposing (..)

import Msg exposing (..)

import Join exposing (..)
import Poll exposing (pullData,updateData)

import Ports exposing (..)


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
         ({ model | ui = ui' }, sendRequestToCreate)

    TypeRoomkey key ->
      let
          lowercaseRoomkey = String.toLower key
          ui' = { ui | userEnteredRoomkey = lowercaseRoomkey
                     , joinErrorMessage = Nothing }
      in
         ({ model | ui = ui' }, Cmd.none)

    PressEnterButton ->
      requestJoin model

    JoinAcceptedOrDenied verdict ->
      let
          ui' = { ui | requestToJoinPending = False
                     , requestToCreatePending = False }
      in
          handleJoinVerdict verdict { model | ui = ui' }

    JoinError httpError ->
      let
          message = Just ("Connection error: "++(toString httpError))
          ui' = { ui | joinErrorMessage = message }
      in
         ({ model | ui = ui' }, Cmd.none)

    ChangeScreen screen ->
      let
          ui' = { ui | screen = screen
                     , instructionsVisible = False }
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
          ui' = { ui | instructionsVisible = True
                     , instructionsButtonEverPressed = True }
          model' = { model | ui = ui' }
      in
          (model', Cmd.none)

    LeaveRoom ->
      let
          ui' = { ui | screen = RoomSelection
                     , instructionsVisible = False }
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


requestJoin : Model -> (Model, Cmd Msg)
requestJoin ({ui} as model) =
  let
      ui' = { ui | requestToJoinPending = True
                 , joinErrorMessage = Nothing }
      effect = sendRequestToJoin ui.userEnteredRoomkey
  in
     ({ model | ui = ui' }, effect)


handleJoinVerdict : JoinVerdict -> Model -> (Model, Cmd Msg)
handleJoinVerdict verdict ({ui} as model) =
  case verdict of
    Accepted roomkey ->
      joinRoom roomkey model

    Denied ->
      let
          message =
            if String.isEmpty ui.userEnteredRoomkey then
              Just "Please type a room key"
            else
              Just "This room doesn't exist"
          ui' = { ui | joinErrorMessage = message }
          effect = setfocus "#roomkey-input"
      in
          ({ model | ui = ui' }, effect)


joinRoom : String -> Model -> (Model, Cmd Msg)
joinRoom roomkey ({ui} as model) =
  let
      ui' = { ui | screen = RoleSelection
                 , requestToJoinPending = False
                 , requestToCreatePending = False
                 , userEnteredRoomkey = "" }
      model' = { model | acceptedRoomkey = Just roomkey
                       , ui = ui' }
  in
     (model', pullData roomkey)


pullIfJoined : Model -> Cmd Msg
pullIfJoined {acceptedRoomkey} =
  case acceptedRoomkey of
    Nothing ->
      Cmd.none

    Just roomkey ->
      pullData roomkey
