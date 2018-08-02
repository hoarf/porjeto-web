module Questionnaire exposing (Progress(..), Questionnaire, defaultQuestionnaire)

import Question exposing (..)


type Progress
    = NotStarted
    | FirstQuestion
    | InTheMiddleOfIt
    | LastQuestion


type alias Questionnaire =
    { progress : Progress
    , previous : List Question
    , current : Question
    , next : List Question
    }


defaultQuestionnaire : Questionnaire
defaultQuestionnaire =
    { progress = NotStarted
    , previous = []
    , current = defaultQuestion
    , next = []
    }
