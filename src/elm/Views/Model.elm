module Views.Model exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
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
                NotLoaded ->
                    text ""

                Loaded user _ ->
                    Views.User.actions user

                Ready user questionnaire ->
                    Views.User.actions user

                Answering user questionnaire ->
                    Views.Questionnaire.actions questionnaire

                Finished questionnaire ->
                    text ""
    in
    div [] [ innerView ]


content : Model -> Html Msg
content model =
    let
        innerView =
            case model of
                NotLoaded ->
                    text ""

                Loaded user _ ->
                    Views.User.form user

                Ready user questionnaire ->
                    Views.User.form user

                Answering user questionnaire ->
                    Views.Questionnaire.actions questionnaire

                Finished questionnaire ->
                    text ""
    in
    section [] [ innerView ]
