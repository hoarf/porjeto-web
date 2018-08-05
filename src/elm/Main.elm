module Main exposing (..)

import Config
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
        , init = NotLoaded ! [ show NotLoaded ]
        , subscriptions = \m -> Sub.none
        }



-- MODEL


show : Model -> Cmd Msg
show model =
    Task.perform QuestionairieHttpRequest (Task.succeed (Ok Questionnaire.default))



-- UPDATE


update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        QuestionairieHttpRequest (Ok a) ->
            Answering User.default a Config.default ! []

        QuestionairieHttpRequest (Err a) ->
            model ! []

        NextQuestion ->
            Model.nextQuestion model ! []

        PreviousQuestion ->
            Model.previousQuestion model ! []

        BeginQuestionnaire ->
            Model.beginQuestionnaire model ! []

        FinishQuestionnaire ->
            Model.finishQuestionnaire model ! []

        Mdl message_ ->
            let
                ( newConfig, cmds ) =
                    Material.update Mdl message_ (Model.getConfig model)
            in
            Model.setConfig model newConfig ! [ cmds ]

        UserChanged email ->
            Model.updateEmail model email ! []



-- VIEW


view : Model -> Html Msg.Msg
view model =
    main_ []
        [ Views.Model.title model
        , Views.Model.content model
        , Views.Model.actions model
        ]
