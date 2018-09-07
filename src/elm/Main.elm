module Main exposing (..)

import Backend
import Html exposing (..)
import Material
import Model exposing (..)
import Msg exposing (..)
import Questionnaire exposing (..)
import Task exposing (..)
import User exposing (..)
import Views.Model exposing (..)


-- APP


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init = Init { mdl = Material.model } ! []
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

        QuestionnaireRetrieveResult (Err a) ->
            model ! []

        EvaluationCreateResult (Ok a) ->
            model ! []

        EvaluationCreateResult (Err a) ->
            model ! []

        NextQuestion ->
            Model.nextQuestion model ! []

        PreviousQuestion ->
            Model.previousQuestion model ! []

        BeginQuestionnaire ->
            model ! Model.postEvaluation model

        FinishQuestionnaire ->
            model ! []

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
