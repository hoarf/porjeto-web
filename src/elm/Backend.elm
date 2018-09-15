module Backend exposing (getQuestionnaireQuestions, postEvaluation)

import EmailInput exposing (..)
import Evaluation exposing (..)
import Http exposing (jsonBody, post)
import Msg exposing (..)
import Questionnaire exposing (..)


postEvaluation : EmailInput -> Cmd Msg
postEvaluation user =
    Http.send EvaluationCreateResult
        (Http.post
            "http://localhost:4000/evaluation"
            (jsonBody (EmailInput.encode user))
            Evaluation.decoder
        )


getQuestionnaireQuestions : Int -> Cmd Msg
getQuestionnaireQuestions questionnaireId =
    Http.send QuestionnaireRetrieveResult
        (Http.get
            ("http://localhost:4000/questionnaire/"
                ++ toString questionnaireId
                ++ "/questions"
            )
            Questionnaire.decoder
        )
