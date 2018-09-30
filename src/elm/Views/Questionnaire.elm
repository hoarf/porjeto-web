module Views.Questionnaire exposing (..)

import Html exposing (..)
import Material
import Material.Button as Button
import Material.Options as Options
import Msg exposing (..)
import Questionnaire exposing (..)
import Views.Question exposing (..)


-- VIEWS


content : Questionnaire -> Material.Model -> Html Msg
content questionnaire mdl =
    Views.Question.view questionnaire.current mdl


actions : Questionnaire -> Material.Model -> Html Msg
actions questionnaire mdl =
    let
        prevButton =
            button_ 0 "Previous" mdl (PreviousQuestion questionnaire.current.answer)

        nextButton =
            button_ 1 "Next" mdl (NextQuestion questionnaire.current.answer)

        finishButton =
            button_ 2 "Finish" mdl FinishQuestionnaire
    in
    case questionnaire.progress of
        FirstQuestion ->
            Options.div [ Options.cs "actions one" ]
                [ nextButton ]

        InTheMiddleOfIt ->
            Options.div [ Options.cs "actions two" ]
                [ prevButton, nextButton ]

        LastQuestion ->
            Options.div [ Options.cs "actions two" ]
                [ prevButton, finishButton ]


button_ : Int -> String -> Material.Model -> Msg -> Html Msg
button_ ix text_ mdl msg =
    Button.render Mdl
        [ ix ]
        mdl
        [ Button.raised
        , Button.ripple
        , Button.colored
        , Options.onClick msg
        ]
        [ text text_ ]
