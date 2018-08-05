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
                NotLoaded ->
                    text ""

                Loaded user _ config ->
                    Views.User.actions user config.mdl

                Ready user questionnaire config ->
                    Views.User.actions user config.mdl

                Answering user questionnaire config ->
                    Views.Questionnaire.actions questionnaire config.mdl

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

                Loaded user _ config ->
                    Views.User.form user config.mdl

                Ready user questionnaire config ->
                    Views.User.form user config.mdl

                Answering user questionnaire config ->
                    Views.Questionnaire.content questionnaire config.mdl

                Finished user ->
                    text ""
    in
    section [] [ innerView ]
