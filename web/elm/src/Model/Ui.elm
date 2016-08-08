module Model.Ui exposing (..)

import Model.Part exposing (..)


type alias Ui =
  { windowSize : (Int, Int)
  , screen : Screen
  , userEnteredRoomkey : String
  , requestToCreatePending : Bool
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
  , requestToCreatePending = False
  , errorMessage = Nothing }
