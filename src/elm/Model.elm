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


mapName : Model -> String -> String -> String -> String
mapName model defaultTitle questionTitle thankYouTitle =
    case model of
        NotLoaded ->
            defaultTitle

        Loaded _ questionnaire ->
            defaultTitle

        Ready _ questionnaire ->
            defaultTitle

        Answering _ questionnaire ->
            questionTitle
                ++ " "
                ++ toString questionnaire.current.order

        Finished _ ->
            thankYouTitle


beginQuestionnaire : Model -> Model
beginQuestionnaire model =
    case model of
        Ready user questionnaire ->
            Answering user questionnaire

        _ ->
            model


updateEmail : Model -> String -> Model
updateEmail model email =
    let
        newUserFn =
            User.updateEmail email
    in
    case model of
        Loaded user questionnaire ->
            let
                newUser =
                    newUserFn user
            in
            if User.isReady user then
                Ready newUser questionnaire
            else
                Loaded newUser questionnaire

        _ ->
            model
