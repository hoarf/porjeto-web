module Msg exposing (..)

import Http
import Questionnaire exposing (..)


type Msg
    = NoOp
    | NextQuestion
    | PreviousQuestion
    | BeginQuestionnaire
    | FinishQuestionnaire
    | QuestionairieHttpRequest (Result Http.Error Questionnaire)
