module Join exposing (requestToJoin,requestToCreate)

import Http
import Task
import Json.Decode as Decode exposing (Decoder,(:=))

import Msg exposing (..)


requestToJoin : String -> Cmd Msg
requestToJoin roomkey =
  let
      url = "/api/join?roomkey=" ++ roomkey
  in
      Http.post verdictDecoder url Http.empty
      |> Task.perform JoinError JoinAcceptedOrDenied


requestToCreate : Cmd Msg
requestToCreate =
  let
      url = "/api/create"
  in
      Http.post verdictDecoder url Http.empty
      |> Task.perform JoinError JoinAcceptedOrDenied


verdictDecoder : Decoder JoinVerdict
verdictDecoder =
  Decode.object1
    (\ms ->
        case ms of
            Nothing ->
                Denied
            Just roomkey ->
                Accepted roomkey)
    (Decode.maybe ("accepted" := Decode.string))
