module Answer exposing (Answer, decoder, descriptionAt, encode, update, valueAt)

import Json.Decode as Decode
import Json.Encode as Encode
import List.Extra exposing (..)
import RecordId exposing (..)


update : Answer -> Int -> Bool -> Answer
update answer ix value =
    { answer | values = setAt ix value answer.values }


type alias Answer =
    { descriptions : List String
    , values : List Bool
    , questionId : RecordId
    }


decoder : Decode.Decoder Answer
decoder =
    Decode.map3 Answer
        (Decode.list Decode.string)
        (Decode.list (Decode.succeed False))
        RecordId.decoder


encode : Answer -> Encode.Value
encode answer =
    let
        getBool =
            valueAt answer.values
    in
    Encode.object
        [ ( "answer1", Encode.bool (getBool 0) )
        , ( "answer2", Encode.bool (getBool 1) )
        , ( "answer3", Encode.bool (getBool 2) )
        , ( "answer4", Encode.bool (getBool 3) )
        , ( "answer5", Encode.bool (getBool 4) )
        ]


valueAt : List Bool -> Int -> Bool
valueAt values ix =
    values
        |> getAt ix
        |> Maybe.withDefault False


descriptionAt : List String -> Int -> String
descriptionAt descriptions ix =
    descriptions
        |> getAt ix
        |> Maybe.withDefault "[NOT FOUND]"
