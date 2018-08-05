module Model exposing (..)

import Config exposing (..)
import Question exposing (..)
import Questionnaire exposing (..)
import User exposing (..)


type Model
    = NotLoaded
    | Loaded User Questionnaire Config
    | Ready User Questionnaire Config
    | Answering User Questionnaire Config
    | Finished User


type Status
    = WithoutData
    | WithData User Questionnaire Config


toStatus : Model -> Status
toStatus model =
    case model of
        Loaded user questionnaire config ->
            WithData user questionnaire config

        Ready user questionnaire config ->
            WithData user questionnaire config

        Answering user questionnaire config ->
            WithData user questionnaire config

        _ ->
            WithoutData


mapConfig : (Config -> a) -> a -> Status -> a
mapConfig fn default status =
    case status of
        WithoutData ->
            default

        WithData user questionnaire config ->
            fn config


setConfig : Model -> Config -> Model
setConfig model config =
    case model of
        Loaded user questionnaire _ ->
            Loaded user questionnaire config

        Ready user questionnaire _ ->
            Ready user questionnaire config

        Answering user questionnaire _ ->
            Answering user questionnaire config

        _ ->
            model


getConfig : Model -> Config
getConfig model =
    model
        |> toStatus
        |> mapConfig identity Config.default


mapName : Model -> String -> String -> String -> String
mapName model defaultTitle questionTitle thankYouTitle =
    case model of
        Answering _ questionnaire config ->
            questionTitle
                ++ " "
                ++ toString questionnaire.current.order

        Finished _ ->
            thankYouTitle

        _ ->
            defaultTitle


beginQuestionnaire : Model -> Model
beginQuestionnaire model =
    case model of
        Ready user questionnaire config ->
            Answering user questionnaire config

        _ ->
            model


finishQuestionnaire : Model -> Model
finishQuestionnaire model =
    case model of
        Answering user questionnaire config ->
            case questionnaire.progress of
                LastQuestion ->
                    Finished user

                _ ->
                    model

        _ ->
            model


updateEmail : Model -> String -> Model
updateEmail model email =
    let
        newUserFn =
            User.updateEmail email
    in
    case model of
        Loaded user questionnaire config ->
            let
                newUser =
                    newUserFn user
            in
            if User.isReady user then
                Ready newUser questionnaire config
            else
                Loaded newUser questionnaire config

        _ ->
            model


previousQuestion : Model -> Model
previousQuestion model =
    case model of
        Answering user questionnaire config ->
            Answering user (Questionnaire.previous questionnaire) config

        _ ->
            model


nextQuestion : Model -> Model
nextQuestion model =
    case model of
        Answering user questionnaire config ->
            Answering user (Questionnaire.next questionnaire) config

        _ ->
            model


updateAnswer : Model -> Question -> Int -> Bool -> Model
updateAnswer model question ix value =
    model
