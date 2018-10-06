module Question exposing (Question, decoder, default, optionAt, q1, updateAnswer)

import Answer exposing (..)
import Json.Decode as Decode
import List.Extra exposing (..)
import RecordId exposing (..)


type alias Question =
    { description : String
    , answer : Answer
    , options : List String
    , order : Int
    , seconds : Int
    , id : RecordId
    }


default : Question
default =
    { description = "What kind of question is this?"
    , answer = Answer [ False ] RecordId.default
    , options = [ "Is this Ok?" ]
    , order = 0
    , seconds = 0
    , id = 0
    }


q1 : Question
q1 =
    { default | order = 1 }


decoder : Decode.Decoder Question
decoder =
    Decode.map6 Question
        (Decode.field "description" Decode.string)
        (Decode.succeed Answer.default)
        (Decode.field "options" (Decode.list Decode.string))
        (Decode.succeed 0)
        (Decode.succeed 1)
        (Decode.field "id" RecordId.decoder)


updateAnswer : Question -> Int -> Bool -> Question
updateAnswer question ix value =
    { question | answer = Answer.update question.answer ix value }


optionAt : List String -> Int -> String
optionAt options ix =
    options
        |> getAt ix
        |> Maybe.withDefault "[NOT FOUND]"
