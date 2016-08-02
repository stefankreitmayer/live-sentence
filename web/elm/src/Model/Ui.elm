module Model.Ui exposing (..)

type alias Ui =
  { windowSize : (Int, Int)
  , screen : Screen }

type Screen
  = RoleSelection
  | Whiteboard


initialUi : Ui
initialUi =
  { windowSize = (500,500)
  , screen = RoleSelection }
