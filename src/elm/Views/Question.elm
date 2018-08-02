module Views.Question exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (..)
import Question exposing (..)


-- VIEWS


default : Question -> Html Msg
default question =
    div []
        [ h2 [] [ text "What is 1 + 2?" ]
        , div [ class "container l3" ]
            [ div [ class "question" ]
                [ div [ class "form-check" ]
                    [ input [ type_ "radio", class "form-check-input", id "1" ] [ label [ class "form-check-label", for "1" ] [ text "1" ] ]
                    ]
                , div [ class "form-check" ]
                    [ input [ type_ "radio", class "form-check-input", id "2" ] [ label [ class "form-check-label", for "2" ] [ text "2" ] ]
                    ]
                , div [ class "form-check" ]
                    [ input [ type_ "radio", class "form-check-input", id "3" ] [ label [ class "form-check-label", for "3" ] [ text "3" ] ]
                    ]
                , div [ class "form-check" ]
                    [ input [ type_ "radio", class "form-check-input", id "4" ] [ label [ class "form-check-label", for "4" ] [ text "Well you see, it depends man. Everything is relative and there is no certain knowledge in the world and stuff..." ] ]
                    ]
                ]
            ]
        ]
