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
                Ready context ->
                    Views.User.actions context.user context.mdl

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
                Ready context ->
                    Views.User.actions context.user context.mdl

                Answering context ->
                    Views.Questionnaire.actions context.questionnaire context.mdl

                _ ->
                    text ""
    in
    section [] [ innerView ]
