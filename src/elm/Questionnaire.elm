module Questionnaire exposing (Progress(..), Questionnaire, decoder, default, next, previous, updateAnswer)

import Json.Decode as Decode
import List.Extra as List
import Question exposing (..)


type Progress
    = FirstQuestion
    | InTheMiddleOfIt
    | LastQuestion


type alias Questionnaire =
    { progress : Progress
    , previous : List Question
    , current : Question
    , next : List Question
    }


decoder : Decode.Decoder Questionnaire
decoder =
    Decode.map4 Questionnaire
        (Decode.succeed FirstQuestion)
        (Decode.succeed [])
        (Decode.map (Maybe.withDefault Question.default)
            (Decode.map List.head (Decode.list Question.decoder))
        )
        (Decode.map (Maybe.withDefault [])
            (Decode.map List.tail (Decode.list Question.decoder))
        )


default : Questionnaire
default =
    { progress = FirstQuestion
    , previous = []
    , current = Question.default
    , next = [ Question.q1 ]
    }


next : Questionnaire -> Questionnaire
next questionnaire =
    let
        newProgress =
            case questionnaire.next of
                head :: [] ->
                    LastQuestion

                _ ->
                    InTheMiddleOfIt

        newPrevious =
            questionnaire.previous ++ [ questionnaire.current ]

        newCurrent =
            questionnaire.next
                |> List.head
                |> Maybe.map identity
                |> Maybe.withDefault questionnaire.current

        newNext =
            questionnaire.next
                |> List.tail
                |> Maybe.map identity
                |> Maybe.withDefault []

        newQuestionnaire =
            { progress = newProgress
            , previous = newPrevious
            , current = newCurrent
            , next = newNext
            }
    in
    case questionnaire.progress of
        FirstQuestion ->
            newQuestionnaire

        InTheMiddleOfIt ->
            newQuestionnaire

        _ ->
            questionnaire


previous : Questionnaire -> Questionnaire
previous questionnaire =
    let
        newProgress =
            case questionnaire.previous of
                head :: [] ->
                    FirstQuestion

                _ ->
                    InTheMiddleOfIt

        newNext =
            questionnaire.next ++ [ questionnaire.current ]

        newCurrent =
            questionnaire.previous
                |> List.head
                |> Maybe.map identity
                |> Maybe.withDefault questionnaire.current

        newPrevious =
            questionnaire.previous
                |> List.tail
                |> Maybe.map identity
                |> Maybe.withDefault []

        newQuestionnaire =
            { progress = newProgress
            , previous = newPrevious
            , current = newCurrent
            , next = newNext
            }
    in
    case questionnaire.progress of
        LastQuestion ->
            newQuestionnaire

        InTheMiddleOfIt ->
            newQuestionnaire

        _ ->
            questionnaire


updateAnswer : Questionnaire -> Int -> Bool -> Questionnaire
updateAnswer questionnaire ix value =
    { questionnaire | current = Question.updateAnswer questionnaire.current ix value }
