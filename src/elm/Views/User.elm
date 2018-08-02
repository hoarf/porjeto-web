module Views.User exposing (..)

import Html exposing (..)
import Msg exposing (..)
import User exposing (..)


default : User -> Html Msg
default user =
    div [] [ text user.email ]
