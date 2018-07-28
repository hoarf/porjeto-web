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
            (welcome model)
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
