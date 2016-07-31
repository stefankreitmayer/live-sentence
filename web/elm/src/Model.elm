module Model exposing (..)

type alias Model =
  { sentence : List Atom }

type alias Atom = String


initialModel : Model
initialModel =
  { sentence = [ "The brown fox", "jumps", "like there's no tomorrow" ] }
