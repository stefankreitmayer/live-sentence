module Join exposing (sendRequestToJoin,sendRequestToCreate)

import Http
import Task
import Json.Decode as Decode exposing (Decoder,(:=))

import Msg exposing (..)


sendRequestToJoin : String -> Cmd Msg
sendRequestToJoin roomkey =
  let
      url = "/api/join?roomkey=" ++ roomkey
  in
      Http.post verdictDecoder url Http.empty
      |> Task.perform JoinError JoinAcceptedOrDenied


sendRequestToCreate : Cmd Msg
sendRequestToCreate =
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
