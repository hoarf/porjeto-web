module Main exposing (..)

-- component import example

import Components.Hello exposing (hello)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- APP


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { email : String
    }


model : Model
model =
    { email = ""
    }



-- UPDATE


type Msg
    = NoOp
    | Increment


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
    main_ []
        [ section [ class "jumbotron full-screen flex-column-evenly-center" ]
            -- (welcome model)
            (question model)
        ]


question : Model -> List (Html Msg)
question question =
    [ h2 [] [ text "What is 1 + 2?" ]
    , div [ class "container l3" ]
        [ div [ class "question" ]
            [ div [ class "form-check" ]
                [ input [ type_ "radio", class "form-check-input", id "1" ] []
                , label [ class "form-check-label", for "1" ] [ text "1" ]
                ]
            , div [ class "form-check" ]
                [ input [ type_ "radio", class "form-check-input", id "2" ] []
                , label [ class "form-check-label", for "2" ] [ text "2" ]
                ]
            , div [ class "form-check" ]
                [ input [ type_ "radio", class "form-check-input", id "3" ] []
                , label [ class "form-check-label", for "3" ] [ text "3" ]
                ]
            , div [ class "form-check" ]
                [ input [ type_ "radio", class "form-check-input", id "4" ] []
                , label [ class "form-check-label", for "4" ] [ text "Well you see, it depends man. Everything is relative and there is no certain knowledge in the world and stuff..." ]
                ]
            ]
        ]
    , div
        [ class "actions" ]
        [ button [ class "btn btn-secondary" ] [ text "Previous" ]
        , button [ class "btn btn-secondary pull-right" ] [ text "Next" ]
        ]
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
