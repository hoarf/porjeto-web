module Questionaire exposing (Questionaire, actions, defaultQuestionaire)

import Html exposing (..)
import Msg exposing (..)


type Progress
    = NotStarted
    | FirstQuestion
    | InTheMiddleOfIt
    | LastQuestion


type alias Questionaire =
    { progress : Progress }


defaultQuestionaire : Questionaire
defaultQuestionaire =
    { progress = NotStarted }



-- VIEWS


actions : { a | progress : Progress } -> Html Msg
actions questionaire =
    case questionaire.progress of
        NotStarted ->
            div [] []

        _ ->
            div [] [ text "hahah" ]
