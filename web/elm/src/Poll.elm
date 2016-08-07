module Poll exposing (pullData,updateData)

import Http
import Json.Decode as Decode exposing (Decoder,(:=),list,string)
import Task exposing (..)

import String exposing (..)

import Model.Part exposing (..)
import Msg exposing (..)


updateData : Part -> List Part -> Cmd Msg
updateData ({name,chosenAtom} as part) parts =
  let
      pos = partIndex part parts 0 |> toString
      val = chosenAtom
      url = "/api/sentence?pos="++pos++"&val="++val
      request = Http.post sentenceDecoder url Http.empty
  in
      Task.perform PollFailure PollSuccess request


pullData : Cmd Msg
pullData =
  let
      url = "/api/sentence"
      request = Http.get sentenceDecoder url
  in
      Task.perform PollFailure PollSuccess request


sentenceDecoder : Decoder (List String)
sentenceDecoder =
  ("sentence" := list string)


partIndex : Part -> List Part -> Int -> Int
partIndex part parts index =
  case parts of
    [] ->
      index
    hd::tl ->
      if hd.name==part.name then
          index
      else
          partIndex part tl (index+1)
