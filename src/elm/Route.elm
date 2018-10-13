module Route exposing (fromLocation, href, modifyUrl, setRoute)

import Html exposing (Attribute)
import Html.Attributes as Attr
import Model exposing (..)
import Msg exposing (Msg(..))
import Navigation exposing (Location)
import Types exposing (..)
import UrlParser as Url exposing ((</>), Parser, oneOf, parseHash, s, string)


-- ROUTING --


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map HomeRoute (s "")
        , Url.map EvaluationRoute (s "evaluations")
        ]



-- INTERNAL --


routeToString : Route -> String
routeToString route =
    let
        pieces =
            case route of
                HomeRoute ->
                    []

                EvaluationRoute ->
                    [ "manage" ]
    in
    "#/" ++ String.join "/" pieces



-- PUBLIC HELPERS --


href : Route -> Attribute msg
href route =
    Attr.href (routeToString route)


modifyUrl : Route -> Cmd msg
modifyUrl =
    routeToString >> Navigation.modifyUrl


fromLocation : Location -> Maybe Route
fromLocation location =
    case ( String.startsWith "#" location.hash, "/" == location.pathname ) of
        ( True, True ) ->
            location
                |> removeQueryParams
                |> parseHash route

        ( False, True ) ->
            Just HomeRoute

        _ ->
            Nothing


removeQueryParams : Location -> Location
removeQueryParams location =
    let
        hash =
            String.split "?" location.hash
                |> List.head
                |> Maybe.withDefault ""
    in
    { location | hash = hash }


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute maybeRoute model =
    case maybeRoute of
        Nothing ->
            Model.toNewPageState model (Loaded NotFound)

        Just HomeRoute ->
            Model.toNewPageState model (Loaded HomePage)

        Just EvaluationRoute ->
            Model.toNewPageState model (Loaded EvaluationPage)
