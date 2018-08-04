module Questionnaire exposing (Progress(..), Questionnaire, defaultQuestionnaire)

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


defaultQuestionnaire : Questionnaire
defaultQuestionnaire =
    { progress = FirstQuestion
    , previous = []
    , current = defaultQuestion
    , next = []
    }
