module Main exposing (..)

-- component import example

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (..)
import Questionnaire exposing (..)
import Task exposing (..)
import User exposing (..)
import Views.Other exposing (..)
import Views.Question exposing (..)
import Views.Questionnaire exposing (..)
import Views.User exposing (..)


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


type Model
    = NotLoaded
    | Loaded User Questionnaire
    | Ready User Questionnaire
    | Answering User Questionnaire
    | Finished User


show : Model -> Cmd Msg
show model =
    Task.perform QuestionairieHttpRequest (Task.succeed (Ok defaultQuestionnaire))



-- UPDATE


update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        QuestionairieHttpRequest (Ok a) ->
            Loaded defaultUser a ! []

        QuestionairieHttpRequest (Err a) ->
            model ! []



-- VIEW


view : Model -> Html Msg.Msg
view model =
    let
        nonSharedView =
            case model of
                NotLoaded ->
                    div [] [ text "Loading Questionnaire..." ]

                Loaded user questionnaire ->
                    Views.User.default user

                Ready user questionnaire ->
                    Views.User.default user

                Answering user questionnaire ->
                    div []
                        [ Views.Question.default questionnaire.current
                        , Views.Questionnaire.actions questionnaire
                        ]

                _ ->
                    div [] []
    in
    main_ []
        [ section [ class "full-screen flex-column-evenly-center" ] [ nonSharedView ]
        ]
