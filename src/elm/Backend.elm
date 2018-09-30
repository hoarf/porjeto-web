module Backend exposing (getQuestionnaireQuestions, postAnswer, postEvaluation)

import Answer exposing (..)
import EmailInput exposing (..)
import Evaluation exposing (..)
import Http exposing (jsonBody, post)
import Json.Decode as Decode
import Msg exposing (..)
import Questionnaire exposing (..)
import RecordId exposing (..)


baseURL : String
baseURL =
    "http://localhost:4000"


postEvaluation : EmailInput -> Cmd Msg
postEvaluation user =
    Http.send EvaluationCreateResult
        (Http.post
            (baseURL ++ "/evaluation")
            (jsonBody (EmailInput.encode user))
            Evaluation.decoder
        )


postAnswer : RecordId -> Answer -> Cmd Msg
postAnswer evaluationId answer =
    Http.send PostAnswerResult
        (Http.post
            (baseURL
                ++ "/evaluation/"
                ++ toString evaluationId
                ++ "/answer/"
                ++ toString answer.questionId
            )
            (jsonBody (Answer.encode answer))
            Answer.decoder
        )


getQuestionnaireQuestions : Int -> Cmd Msg
getQuestionnaireQuestions questionnaireId =
    Http.send QuestionnaireRetrieveResult
        (Http.get
            (baseURL
                ++ "/evaluation/"
                ++ toString questionnaireId
                ++ "/questions"
            )
            (Decode.field "data" Questionnaire.decoder)
        )
