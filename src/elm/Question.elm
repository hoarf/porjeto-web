module Question exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (..)


type Answer
    = String


type alias Question =
    { description : String
    , answer1 : Answer
    , answer2 : Answer
    , answer3 : Answer
    , answer4 : Answer
    , answer5 : Answer
    , selected : Maybe Answer
    , seconds : Int
    }



-- VIEWS


view : Question -> Html Msg
view question =
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
