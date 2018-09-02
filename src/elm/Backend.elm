module Backend exposing (getQuestionnaireQuestions, postEvaluation)

import Evaluation exposing (..)
import Http exposing (jsonBody, post)
import Msg exposing (..)
import User exposing (..)


postEvaluation : Int -> Cmd Msg
postEvaluation userId =
    Http.send EvaluationCreateResult
        (Http.post
            "http://localhost:4000/evaluation"
            (jsonBody (User.encode user))
            Evaluation.decoder
        )


getQuestionnaireQuestions : Int -> Cmd Msg
getQuestionnaireQuestions questionnaireId =
    Http.send QuestionnaireRetrieveResult
        (Http.get
            "http://localhost:4000/questionnaires//questions"
            Questionnaire.decoder
        )
