module Views.Model exposing (..)

import Html exposing (..)
import Model exposing (..)
import Msg exposing (..)
import Views.Questionnaire
import Views.User


title : Model -> Html Msg
title model =
    h1 []
        [ Model.mapName model "Welcome!" "Question" "Thank you!" |> text ]


actions : Model -> Html Msg
actions model =
    let
        innerView =
            case model of
                Init context ->
                    Views.User.actions context.email context.mdl

                Answering context ->
                    Views.Questionnaire.actions context.questionnaire context.mdl

                _ ->
                    text ""
    in
    div [] [ innerView ]


content : Model -> Html Msg
content model =
    let
        innerView =
            case model of
                Init context ->
                    Views.User.form context.email context.mdl

                LoadingEval conext ->
                    text "Loading evaluation.."

                LoadingQuestionnaire conext ->
                    text "Loading questionnaire.."

                Answering context ->
                    Views.Questionnaire.content context.questionnaire context.mdl

                Error message ->
                    text message

                _ ->
                    text ""
    in
    section [] [ innerView ]
