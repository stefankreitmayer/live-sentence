module Model exposing (..)

import String

import Model.Ui exposing (..)


type alias Model =
  { ui : Ui
  , sentence : List Atom
  , parts : List Part }

type alias Part =
  { name : String
  , atoms : List Atom }

type alias Atom = String


initialModel : Model
initialModel =
  { ui = initialUi
  , sentence = initialSentence dummyParts
  , parts = dummyParts }


dummyParts : List Part
dummyParts =
  [ Part "subject" (String.split "," "the dog,the goose,nobody")
  , Part "verb" (String.split "," "chases,ignores")
  , Part "object" (String.split "," "butterflies,dreams,you")
  , Part "rest" (String.split "," "around the house,tonight,forever") ]


initialSentence : List Part -> List Atom
initialSentence parts =
  parts
  |> List.map (\part -> List.head part.atoms |> Maybe.withDefault "-")
