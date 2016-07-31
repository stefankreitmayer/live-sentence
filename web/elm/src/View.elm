module View exposing (view)

import Html exposing (Html,div)
import Html.Attributes exposing (class)

import Model exposing (..)
import Msg exposing (..)


view : Model -> Html Msg
view model =
  let
      sentence = renderSentence model.sentence
  in
      sentence


renderSentence : List Atom -> Html Msg
renderSentence atoms =
  let
      items =
        atoms
        |> List.map (\atom -> div [] [ Html.text atom ])
  in
      div [] items
