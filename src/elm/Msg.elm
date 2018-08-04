module Msg exposing (..)

import Http
import Material
import Questionnaire exposing (..)


type Msg
    = NoOp
    | Mdl (Material.Msg Msg)
    | NextQuestion
    | PreviousQuestion
    | BeginQuestionnaire
    | FinishQuestionnaire
    | UserChanged String
    | QuestionairieHttpRequest (Result Http.Error Questionnaire)
