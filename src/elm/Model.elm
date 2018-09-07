module Model exposing (..)

import Backend exposing (..)
import Evaluation exposing (..)
import Material exposing (update)
import Msg exposing (..)
import Questionnaire exposing (..)
import User exposing (..)


type Model
    = Init { mdl : Material.Model }
    | Ready { mdl : Material.Model, user : Maybe User }
    | LoadingEval { mdl : Material.Model, user : User }
    | LoadingQuestionnaire { mdl : Material.Model, user : User, eval : Evaluation }
    | Answering { mdl : Material.Model, user : User, eval : Evaluation, questionnaire : Questionnaire }
    | Finished { mdl : Material.Model, user : User, eval : Evaluation, questionnaire : Questionnaire }


mapName : Model -> String -> String -> String -> String
mapName model defaultTitle questionTitle thankYouTitle =
    case model of
        Answering context ->
            questionTitle
                ++ " "
                ++ toString context.questionnaire.current.order

        Finished context ->
            thankYouTitle

        _ ->
            defaultTitle



-- beginQuestionnaire : Model -> Model
-- beginQuestionnaire model =
--     case model of
--         Ready user questionnaire config ->
--             Answering user questionnaire config
--         _ ->
--             model
-- finishQuestionnaire : Model -> Model
-- finishQuestionnaire model =
--     case model of
--         Answering user questionnaire config ->
--             case questionnaire.progress of
--                 LastQuestion ->
--                     Finished user
--                 _ ->
--                     model
--         _ ->
--             model


toAnswering : Model -> Questionnaire -> Model
toAnswering model questionnaire =
    case model of
        LoadingQuestionnaire context ->
            Answering
                { user = context.user
                , mdl = context.mdl
                , eval = context.eval
                , questionnaire = questionnaire
                }

        _ ->
            model


updateEmail : Model -> String -> Model
updateEmail model email =
    let
        newUser =
            Just { email = email }
    in
    case model of
        Ready context ->
            Ready { context | user = newUser }

        _ ->
            model


previousQuestion : Model -> Model
previousQuestion model =
    case model of
        Answering context ->
            Answering { context | questionnaire = Questionnaire.next context.questionnaire }

        _ ->
            model


postEvaluation : Model -> List (Cmd Msg.Msg)
postEvaluation model =
    case model of
        LoadingEval context ->
            [ Backend.postEvaluation context.user ]

        _ ->
            []


nextQuestion : Model -> Model
nextQuestion model =
    case model of
        Answering context ->
            Answering { context | questionnaire = Questionnaire.next context.questionnaire }

        _ ->
            model


updateAnswer : Model -> Int -> Bool -> Model
updateAnswer model ix value =
    case model of
        Answering context ->
            Answering { context | questionnaire = Questionnaire.updateAnswer context.questionnaire ix value }

        _ ->
            model


updateMdl model message_ =
    case model of
        Answering context ->
            let
                ( newContext, cmds ) =
                    Material.update Mdl message_ context
            in
            ( Answering newContext, cmds )

        _ ->
            ( model, Cmd.none )
