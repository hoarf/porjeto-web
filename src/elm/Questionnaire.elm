module Questionnaire exposing (Progress(..), Questionnaire, default, next)

import Question exposing (..)


type Progress
    = FirstQuestion
    | InTheMiddleOfIt
    | SingleQuestion
    | LastQuestion


type alias Questionnaire =
    { progress : Progress
    , previous : List Question
    , current : Question
    , next : List Question
    }


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
            questionnaire.next
                |> List.head
                |> Maybe.map (\a -> InTheMiddleOfIt)
                |> Maybe.withDefault LastQuestion

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

        newQuestionnarie =
            { progress = newProgress
            , previous = newPrevious
            , current = newCurrent
            , next = newNext
            }
    in
    case questionnaire.progress of
        FirstQuestion ->
            newQuestionnarie

        InTheMiddleOfIt ->
            newQuestionnarie

        _ ->
            questionnaire
