module Model exposing (..)

import Material
import Questionnaire exposing (..)
import User exposing (..)


type Model
    = NotLoaded
    | Loaded User Questionnaire
    | Ready User Questionnaire
    | Answering User Questionnaire
    | Finished User


getUser : Model -> User
getUser model =
    mapUser identity model


setUser : Model -> User -> Model
setUser model user =
    case model of
        NotLoaded ->
            model

        Loaded _ questionnaire ->
            Loaded user questionnaire

        Ready _ questionnaire ->
            Ready user questionnaire

        Answering _ questionnaire ->
            Answering user questionnaire

        Finished _ ->
            Finished user


mapUser : (User -> a) -> Model -> a
mapUser fn model =
    case model of
        NotLoaded ->
            fn User.default

        Loaded user questionnaire ->
            fn user

        Ready user questionnaire ->
            fn user

        Answering user questionnaire ->
            fn user

        Finished user ->
            fn user


applyUser : (User -> User) -> Model -> Model
applyUser fn model =
    case model of
        NotLoaded ->
            model

        Loaded user questionnaire ->
            Loaded (fn user) questionnaire

        Ready user questionnaire ->
            Ready (fn user) questionnaire

        Answering user questionnaire ->
            Answering (fn user) questionnaire

        Finished user ->
            Finished (fn user)
