module Model.Ui exposing (..)

import Model.Part exposing (..)


type alias Ui =
  { windowSize : (Int, Int)
  , screen : Screen }

type Screen
  = RoleSelection
  | Whiteboard
  | PartScreen Part


initialUi : Ui
initialUi =
  { windowSize = (500,500)
  , screen = RoleSelection }
