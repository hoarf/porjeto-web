module Main exposing (..)

import EmailInput
import Html exposing (..)
import Http exposing (Response)
import Json.Decode as Decode
import Material
import Model exposing (..)
import Msg exposing (..)
import Views.Model exposing (..)


-- APP


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init =
            Init
                { mdl = Material.model
                , email = EmailInput.default ""
                }
                ! []
        , subscriptions = \m -> Sub.none
        }



-- UPDATE


update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        QuestionnaireRetrieveResult (Ok questionnaire) ->
            Model.toAnswering model questionnaire ! []

        QuestionnaireRetrieveResult (Err error) ->
            Error (decodeError error) ! []

        EvaluationCreateResult (Ok evaluation) ->
            Model.toLoadingQuestionnaire model evaluation

        EvaluationCreateResult (Err error) ->
            Error (decodeError error) ! []

        NextQuestion ->
            Model.nextQuestion model ! []

        PreviousQuestion ->
            Model.previousQuestion model ! []

        BeginQuestionnaire ->
            Model.toLoadingEval model

        FinishQuestionnaire ->
            Model.toFinished model

        Mdl message_ ->
            Model.updateMdl model message_

        UserChanged email ->
            Model.updateEmail model email ! []

        UpdateAnswer ix value ->
            Model.updateAnswer model ix value ! []



-- VIEW


view : Model -> Html Msg.Msg
view model =
    main_ []
        [ Views.Model.title model
        , Views.Model.content model
        , Views.Model.actions model
        ]


decodeError : Http.Error -> String
decodeError error =
    let
        err =
            toString error
    in
    case error of
        Http.BadStatus response ->
            parseError response.body

        _ ->
            "Something went wrong: " ++ err


parseError : String -> String
parseError body =
    case Decode.decodeString (Decode.field "message" Decode.string) body of
        Ok value ->
            value

        Err error ->
            "Invalid Response."
