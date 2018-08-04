module Views.Questionnaire exposing (..)

import Html exposing (..)
import Msg exposing (..)
import Questionnaire exposing (..)


-- VIEWS


actions : { a | progress : Progress } -> Html Msg
actions questionnaire =
    div [] []
