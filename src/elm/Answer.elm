module Answer exposing (Answer, decoder, default, encode, update, valueAt)

import Json.Decode as Decode
import Json.Encode as Encode
import List.Extra exposing (..)
import RecordId exposing (..)


update : Answer -> Int -> Bool -> Answer
update answer ix value =
    { answer | values = setAt ix value answer.values }


type alias Answer =
    { values : List Bool
    , questionId : RecordId
    }


default : Answer
default =
    { values = [ False, False, False, False, False ]
    , questionId = RecordId.default
    }


decoder : Decode.Decoder Answer
decoder =
    Decode.map2 Answer
        (Decode.field "options" <| Decode.list Decode.bool)
        (Decode.field "question_id" RecordId.decoder)


encode : Answer -> Encode.Value
encode answer =
    let
        getBool =
            valueAt answer.values
    in
    Encode.object
        [ ( "values", Encode.list (List.map Encode.bool answer.values) ) ]


valueAt : List Bool -> Int -> Bool
valueAt values ix =
    values
        |> getAt ix
        |> Maybe.withDefault False
