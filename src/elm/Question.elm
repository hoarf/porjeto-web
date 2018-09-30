module Question exposing (Question, decoder, default, q1, updateAnswer)

import Answer exposing (..)
import Json.Decode as Decode
import RecordId exposing (..)


type alias Question =
    { description : String
    , answer : Answer
    , order : Int
    , seconds : Int
    , id : RecordId
    }


default : Question
default =
    { description = "What kind of question is this?"
    , answer = Answer [ "I dunno" ] [ False ] RecordId.default
    , order = 0
    , seconds = 0
    , id = 0
    }


q1 : Question
q1 =
    { default | order = 1 }


decoder : Decode.Decoder Question
decoder =
    Decode.map5 Question
        (Decode.field "description" Decode.string)
        (Decode.field "answer" Answer.decoder)
        (Decode.succeed 0)
        (Decode.succeed 1)
        (Decode.field "id" RecordId.decoder)


updateAnswer : Question -> Int -> Bool -> Question
updateAnswer question ix value =
    { question | answer = Answer.update question.answer ix value }
