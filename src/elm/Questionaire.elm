module Questionaire exposing (actions)

import Html exposing (..)
import Msg exposing (..)
import Types exposing (..)


-- VIEWS


actions : { a | progress : Progress } -> Html Msg
actions questionaire =
    case questionaire.progress of
        NotStarted ->
            div [] []

        _ ->
            div [] [ text "hahah" ]
