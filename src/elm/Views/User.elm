module Views.User exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events.Extra exposing (..)
import Material
import Material.Button as Button
import Material.Options as Options
import Material.Textfield as Textfield
import Msg exposing (..)
import User exposing (..)


actions : User -> Html Msg
actions user =
    Options.div [ Options.cs "actions user" ]
        [ Button.render Mdl
            [ 1 ]
            user.mdl
            [ Button.raised
            , Button.ripple
            , Button.colored
            , Options.cs "pull-end"
            , Options.onClick BeginQuestionnaire
            , Button.disabled |> Options.when (User.isNotReady user)
            ]
            [ text "Begin Questionnaire" ]
        ]


form : User -> Html Msg
form user =
    Options.div [ Options.cs "content" ]
        [ p [] [ text welcome ]
        , Textfield.render Mdl
            [ 0 ]
            user.mdl
            [ Textfield.label "Email"
            , Textfield.floatingLabel
            , Textfield.email
            , Textfield.autofocus
            , Options.attribute (onEnter BeginQuestionnaire)
            , Options.onInput UserChanged
            ]
            []
        ]


welcome : String
welcome =
    """
    Hey! Thank you very much for being a part of this, I really appreciate it.
    I need a way to identify users so I'm asking for your e-mail here.
    Do not worry, I am not going to spam you or anything.
    """
