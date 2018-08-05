module Model exposing (..)

import Config exposing (..)
import Questionnaire exposing (..)
import User exposing (..)


type Model
    = NotLoaded
    | Loaded User Questionnaire Config
    | Ready User Questionnaire Config
    | Answering User Questionnaire Config
    | Finished User


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
    case model of
        Loaded user questionnaire config ->
            config

        Ready user questionnaire config ->
            config

        Answering user questionnaire config ->
            config

        _ ->
            Config.default


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
