module Questionnaire exposing (Progress(..), Questionnaire, default)

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
    { progress = SingleQuestion
    , previous = []
    , current = Question.default
    , next = []
    }
