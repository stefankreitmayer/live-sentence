module Model.Ui exposing (..)

import Model.Part exposing (..)


type alias Ui =
  { windowSize : (Int, Int)
  , screen : Screen
  , errorMessage : Maybe String }

type Screen
  = RoleSelection
  | Whiteboard
  | PartScreen String


initialUi : Ui
initialUi =
  { windowSize = (500,500)
  , screen = RoleSelection
  , errorMessage = Nothing }
