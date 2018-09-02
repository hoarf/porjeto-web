module Msg exposing (..)

import Evaluation exposing (..)
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
    | UpdateAnswer Int Bool
    | QuestionnaireRetrieveResult (Result Http.Error Questionnaire)
    | EvaluationCreateResult (Result Http.Error Evaluation)
