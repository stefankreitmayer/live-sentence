module Model exposing (..)

import Model.Ui exposing (..)


type alias Model =
  { ui : Ui
  , sentence : List Atom }

type alias Atom = String


initialModel : Model
initialModel =
  { ui = initialUi
  , sentence = [ "The brown fox", "jumps", "like there's no tomorrow" ] }
