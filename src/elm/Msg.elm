module Msg exposing (..)

import Answer exposing (..)
import Evaluation exposing (..)
import Http
import Material
import Questionnaire exposing (..)


type Msg
    = NoOp
    | Mdl (Material.Msg Msg)
    | NextQuestion Answer
    | PreviousQuestion Answer
    | BeginQuestionnaire
    | FinishQuestionnaire
    | UserChanged String
    | UpdateAnswer Int Bool
    | QuestionnaireRetrieveResult (Result Http.Error Questionnaire)
    | EvaluationCreateResult (Result Http.Error Evaluation)
    | PostAnswerResult (Result Http.Error Answer)
