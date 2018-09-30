module Views.User exposing (..)

import EmailInput exposing (..)
import Html exposing (..)
import Html.Events.Extra exposing (..)
import Material
import Material.Button as Button
import Material.Options as Options
import Material.Textfield as Textfield
import Msg exposing (..)


actions : EmailInput -> Material.Model -> Html Msg
actions emailInput mdl =
    Options.div [ Options.cs "actions one" ]
        [ Button.render Mdl
            [ 1 ]
            mdl
            [ Button.raised
            , Button.ripple
            , Button.colored
            , Options.cs "pull-end"
            , Options.onClick BeginQuestionnaire
            , Button.disabled |> Options.when (EmailInput.isInvalid emailInput)
            ]
            [ text "Begin Questionnaire" ]
        ]


form : EmailInput -> Material.Model -> Html Msg
form user mdl =
    Options.div [ Options.cs "content" ]
        [ p [] [ text welcome ]
        , Textfield.render Mdl
            [ 0 ]
            mdl
            [ Textfield.label "Email"
            , Textfield.floatingLabel
            , Textfield.email
            , Textfield.autofocus
            , Options.attribute (onEnter BeginQuestionnaire)
            , Options.onInput UserChanged
            ]
            []
        , p [] [ user.validation |> Maybe.withDefault "" |> text ]
        ]


welcome : String
welcome =
    """
    Hey! Thank you very much for being a part of this, I really appreciate it.
    I need a way to identify users so I'm asking for your e-mail here.
    Do not worry, I am not going to spam you or anything.
    """
