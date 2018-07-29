module Main exposing (..)

-- component import example

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (..)
import Question exposing (..)
import Questionaire exposing (..)
import User exposing (..)


-- APP


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = NotLoaded, view = view, update = update }



-- MODEL


type Model
    = NotLoaded
    | Loaded Questionaire
    | Ready User Questionaire
    | Answering User Question Questionaire
    | Finished User



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        Increment ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    let
        nonSharedView =
            case model of
                Answering user question questionaire ->
                    div []
                        [ Question.view question
                        , Questionaire.actions questionaire
                        ]

                _ ->
                    div [] []
    in
    main_ []
        [ section [ class "jumbotron full-screen flex-column-evenly-center" ] [ nonSharedView ]
        ]


welcome : { email : email } -> List (Html Msg)
welcome email =
    [ h2 [] [ text "Before we begin, please tell me your email" ]
    , h3 [] [ text "It will only be used as an identifier. I am not gonna spam you =)" ]
    , div [ class "container l3" ]
        [ div [ class "form-group" ]
            [ label [] [ text "Email" ]
            , input [ type_ "email", class "form-control" ] []
            ]
        , button [ type_ "submit", class "btn btn-primary pull-right" ] [ text "Begin" ]
        ]
    ]
