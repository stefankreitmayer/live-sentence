module Model exposing (..)

import String

import Model.Ui exposing (..)
import Model.Part exposing (..)


type alias Model =
  { ui : Ui
  , parts : List Part
  , acceptedRoomkey : Maybe String
  , connectionStatus : ConnectionStatus }

type ConnectionStatus
  = Connecting
  | Connected
  | ConnectionError String


initialModel : Model
initialModel =
  { ui = initialUi
  , parts = dummyParts
  , acceptedRoomkey = Nothing
  , connectionStatus = Connecting }


sentence : List Part -> List Atom
sentence parts =
  List.map (\part -> part.chosenAtom) parts
