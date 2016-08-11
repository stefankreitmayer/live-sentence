module Model.Ui exposing (..)

import Model.Part exposing (..)


type alias Ui =
  { windowSize : (Int, Int)
  , screen : Screen
  , userEnteredRoomkey : String
  , requestToJoinPending : Bool
  , requestToCreatePending : Bool
  , instructionsVisible : Bool
  , instructionsButtonEverPressed : Bool -- suppress initial slide animation
  , roomNotFoundMessageVisible : Bool
  , errorMessage : Maybe String }

type Screen
  = RoomSelection
  | RoleSelection
  | Whiteboard
  | PartScreen String


initialUi : Ui
initialUi =
  { windowSize = (500,500)
  , screen = RoomSelection
  , userEnteredRoomkey = ""
  , requestToJoinPending = False
  , requestToCreatePending = False
  , instructionsVisible = False
  , instructionsButtonEverPressed = False
  , roomNotFoundMessageVisible = False
  , errorMessage = Nothing }
