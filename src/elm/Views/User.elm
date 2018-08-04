module Views.User exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Material
import Material.Button as Button
import Material.Options as Options
import Material.Textfield as Textfield
import Msg exposing (..)
import User exposing (..)


default : User -> Html Msg
default user =
    Options.div []
        [ Options.div []
            [ p [] [ text "Thanks for doing this. I really appreciate it. Before we begin I need you to input your email. Don't worry, I am not going to send you any span, this is just for identification purposes." ]
            ]
        , Options.div
            [ Options.cs "flex-column-evenly-center" ]
            [ Textfield.render Mdl
                [ 0 ]
                user.mdl
                [ Textfield.label "E-mail"
                , Textfield.floatingLabel
                , Textfield.email
                , Textfield.autofocus
                , Options.onInput UserChanged
                ]
                []
            , Button.render Mdl
                [ 1 ]
                user.mdl
                [ Button.raised
                , Button.ripple
                , Button.colored
                , Options.cs "pull-end"
                , Button.disabled |> Options.when (User.isNotReady user)
                ]
                [ text "Begin Questionnaire" ]
            ]
        ]
