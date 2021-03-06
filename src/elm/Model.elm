module Model exposing (..)

import Answer exposing (..)
import Backend exposing (..)
import EmailInput exposing (..)
import Evaluation exposing (..)
import Material exposing (update)
import Msg exposing (..)
import Questionnaire exposing (..)
import Types exposing (..)
import User exposing (..)


type Model
    = Init
        { mdl : Material.Model
        , pageState : PageState
        , email : EmailInput
        }
    | LoadingEval
        { mdl : Material.Model
        , pageState : PageState
        , user : User
        }
    | LoadingQuestionnaire
        { mdl : Material.Model
        , pageState : PageState
        , user : User
        , eval : Evaluation
        }
    | Answering
        { mdl : Material.Model
        , pageState : PageState
        , user : User
        , eval : Evaluation
        , questionnaire : Questionnaire
        }
    | Finished
        { mdl : Material.Model
        , pageState : PageState
        , user : User
        , eval : Evaluation
        , questionnaire : Questionnaire
        }
    | Error String


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


toNewPageState : Model -> PageState -> ( Model, Cmd Msg )
toNewPageState model pageState =
    case model of
        Answering context ->
            Answering { context | pageState = pageState } ! []

        Finished context ->
            Finished { context | pageState = pageState } ! []

        Init context ->
            Init { context | pageState = pageState } ! []

        LoadingEval context ->
            LoadingEval { context | pageState = pageState } ! []

        LoadingQuestionnaire context ->
            LoadingQuestionnaire { context | pageState = pageState } ! []

        _ ->
            model ! []


toAnswering : Model -> Questionnaire -> Model
toAnswering model questionnaire =
    case model of
        LoadingQuestionnaire context ->
            Answering
                { user = context.user
                , pageState = context.pageState
                , mdl = context.mdl
                , eval = context.eval
                , questionnaire = questionnaire
                }

        _ ->
            model


toLoadingEval : Model -> ( Model, Cmd Msg )
toLoadingEval model =
    case model of
        Init context ->
            LoadingEval
                { mdl = context.mdl
                , user = { email = context.email.input }
                , pageState = context.pageState
                }
                ! [ Backend.postEvaluation context.email ]

        _ ->
            model ! []


toFinished : Model -> ( Model, Cmd Msg )
toFinished model =
    case model of
        Answering context ->
            let
                finishedEval =
                    context.eval
            in
            Answering context ! [ Backend.putEvaluation { finishedEval | status = "finished" } ]

        _ ->
            model ! []


toDone : Model -> ( Model, Cmd Msg )
toDone model =
    case model of
        Answering context ->
            Finished context ! []

        _ ->
            model ! []


toLoadingQuestionnaire : Model -> Evaluation -> ( Model, Cmd Msg )
toLoadingQuestionnaire model evaluation =
    case model of
        LoadingEval context ->
            LoadingQuestionnaire
                { mdl = context.mdl
                , user = context.user
                , pageState = context.pageState
                , eval = evaluation
                }
                ! [ Backend.getQuestionnaireQuestions evaluation.questionnaireId ]

        _ ->
            model ! []


updateEmail : Model -> String -> Model
updateEmail model email =
    case model of
        Init context ->
            Init { context | email = EmailInput.default email }

        _ ->
            model


previousQuestion : Model -> Answer -> ( Model, Cmd Msg )
previousQuestion model answer =
    case model of
        Answering context ->
            Answering { context | questionnaire = Questionnaire.previous context.questionnaire }
                ! [ Backend.putAnswer context.eval.id answer ]

        _ ->
            model ! []


nextQuestion : Model -> Answer -> ( Model, Cmd Msg )
nextQuestion model answer =
    case model of
        Answering context ->
            Answering { context | questionnaire = Questionnaire.next context.questionnaire }
                ! [ Backend.putAnswer context.eval.id answer ]

        _ ->
            model ! []


updateAnswer : Model -> Int -> Bool -> Model
updateAnswer model ix value =
    case model of
        Answering context ->
            Answering { context | questionnaire = Questionnaire.updateAnswer context.questionnaire ix value }

        _ ->
            model


updateMdl : Model -> Material.Msg Msg -> ( Model, Cmd Msg )
updateMdl model message_ =
    case model of
        Answering context ->
            let
                ( newContext, cmds ) =
                    Material.update Mdl message_ context
            in
            Answering newContext ! [ cmds ]

        _ ->
            model ! [ Cmd.none ]


updateValidation : Model -> String -> Model
updateValidation model validation =
    case model of
        Init context ->
            Init { context | email = EmailInput.updateValidation context.email validation }

        _ ->
            model
