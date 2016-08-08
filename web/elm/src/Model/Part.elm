module Model.Part exposing (..)

import String


type alias Part =
  { name : String
  , atoms : List Atom
  , chosenAtom : Atom }

type alias Atom = String


dummyParts : List Part
dummyParts =
  [ createPart "subject" "our dog;the goose;nobody;everyone;a squirrel"
  , createPart "adverb" "often;rarely;probably;usually;surprisingly;secretly;inconspicuously"
  , createPart "verb" "chases;eats;ignores;delivers;imagines;tells on;desires;obscures"
  , createPart "object" "butterflies;dreams;your head;life, the universe, and everything;the usual suspects;the obvious;nothing;someone special;random stuff" ]
  -- , createPart "adverb" "around the house;tonight;like there's no tomorrow;like most of us have probably done at one point or another" ]


createPart : String -> String -> Part
createPart name stringOfAtoms =
  let
      atoms = String.split ";" stringOfAtoms
      chosenAtom = atoms |> List.head |> Maybe.withDefault "-"
  in
      Part name atoms chosenAtom


findPart : List Part -> String -> Maybe Part
findPart parts name =
  parts
  |> List.filter (\part -> part.name==name)
  |> List.head
