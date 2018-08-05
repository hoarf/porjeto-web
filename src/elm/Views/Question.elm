module Views.Question exposing (..)

import Html exposing (..)
import Material
import Material.List as Lists
import Material.Options as Options
import Material.Toggles as Toggles
import Msg exposing (..)
import Question exposing (..)


-- VIEWS


view : Question -> Material.Model -> Html Msg
view question mdl =
    Options.div []
        [ h3 [] [ text question.description ]
        , Lists.ul []
            [ Lists.li [] [ Lists.content [] [ checkbox_ 1 question.answer1 mdl ] ]
            , Lists.li [] [ Lists.content [] [ checkbox_ 2 question.answer2 mdl ] ]
            , Lists.li [] [ Lists.content [] [ checkbox_ 3 question.answer3 mdl ] ]
            , Lists.li [] [ Lists.content [] [ checkbox_ 4 question.answer4 mdl ] ]
            , Lists.li [] [ Lists.content [] [ checkbox_ 5 question.answer5 mdl ] ]
            ]
        ]


checkbox_ : Int -> Answer -> Material.Model -> Html Msg
checkbox_ ix (Answer text_) mdl =
    Toggles.checkbox Mdl
        [ ix ]
        mdl
        [ Toggles.ripple
        , Toggles.value True
        ]
        [ text text_ ]
