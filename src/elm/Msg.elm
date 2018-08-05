module Msg exposing (..)

import Http
import Material
import Question exposing (..)
import Questionnaire exposing (..)


type Msg
    = NoOp
    | Mdl (Material.Msg Msg)
    | NextQuestion
    | PreviousQuestion
    | BeginQuestionnaire
    | FinishQuestionnaire
    | UserChanged String
    | UpdateAnswer Question Int Bool
    | QuestionairieHttpRequest (Result Http.Error Questionnaire)
