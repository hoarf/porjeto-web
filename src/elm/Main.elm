module Main exposing (..)

-- component import example

import Html exposing (..)
import Html.Attributes exposing (..)
import Material
import Material.Progress as Loading
import Model exposing (..)
import Msg exposing (..)
import Questionnaire exposing (..)
import Task exposing (..)
import Tuple exposing (..)
import User exposing (..)
import Views.Model exposing (..)
import Views.Other exposing (..)
import Views.Question exposing (..)
import Views.Questionnaire exposing (..)
import Views.User exposing (..)


-- APP


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init = NotLoaded ! [ show NotLoaded ]
        , subscriptions = \m -> Sub.none
        }



-- MODEL


show : Model -> Cmd Msg
show model =
    Task.perform QuestionairieHttpRequest (Task.succeed (Ok defaultQuestionnaire))



-- UPDATE


update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        QuestionairieHttpRequest (Ok a) ->
            Loaded User.default a ! []

        QuestionairieHttpRequest (Err a) ->
            model ! []

        NextQuestion ->
            model ! []

        PreviousQuestion ->
            model ! []

        BeginQuestionnaire ->
            Model.beginQuestionnaire model ! []

        FinishQuestionnaire ->
            model ! []

        Mdl message_ ->
            let
                ( newUser, cmds ) =
                    Material.update Mdl message_ (Model.getUser model)
            in
            Model.setUser model newUser ! [ cmds ]

        UserChanged email ->
            Model.updateEmail model email ! []



-- VIEW


view : Model -> Html Msg.Msg
view model =
    main_ []
        [ Views.Model.title model
        , Views.Model.content model
        , Views.Model.actions model
        ]
