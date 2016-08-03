module Model.Part exposing (..)

type alias Part =
  { name : String
  , atoms : List Atom }

type alias Atom = String
