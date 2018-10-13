module Msg exposing (..)

import Answer exposing (..)
import Evaluation exposing (..)
import Http
import Material
import Questionnaire exposing (..)
import Types exposing (..)


type Msg
    = NoOp
    | Mdl (Material.Msg Msg)
    | SetRoute (Maybe Route)
    | NextQuestion Answer
    | PreviousQuestion Answer
    | BeginQuestionnaire
    | FinishQuestionnaire
    | UserChanged String
    | UpdateAnswer Int Bool
    | QuestionnaireRetrieveResult (Result Http.Error Questionnaire)
    | EvaluationCreateResult (Result Http.Error Evaluation)
    | EvaluationUpdateResult (Result Http.Error Evaluation)
    | AnswerUpdateResult (Result Http.Error Answer)
