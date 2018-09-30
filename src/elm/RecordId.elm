module RecordId exposing (RecordId, decoder, default)

import Json.Decode as Decode


type alias RecordId =
    Int


decoder =
    Decode.int


default =
    0
