module Msg exposing (..)

import Http
import Types exposing (..)


type Msg
    = NoOp
    | QuestionairieHttpRequest (Result Http.Error Questionaire)
