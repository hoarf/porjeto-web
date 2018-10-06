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
        (Http.request
            { method = "PUT"
            , headers = []
            , url =
                baseURL
                    ++ "/evaluation/"
                    ++ toString evaluationId
                    ++ "/answer/"
                    ++ toString answer.questionId
            , body = jsonBody (Answer.encode answer)
            , expect = Http.expectJson <| Decode.field "data" Answer.decoder
            , timeout = Nothing
            , withCredentials = False
            }
        )


getQuestionnaireQuestions : Int -> Cmd Msg
getQuestionnaireQuestions questionnaireId =
    Http.send QuestionnaireRetrieveResult
        (Http.get
            (baseURL
                ++ "/questionnaire/"
                ++ toString questionnaireId
                ++ "/questions"
            )
            (Decode.field "data" Questionnaire.decoder)
        )
