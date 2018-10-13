module Types exposing (..)


type Route
    = HomeRoute
    | EvaluationRoute


type Page
    = HomePage
    | EvaluationPage
    | NotFound


type PageState
    = Loaded Page
    | TransitioningFrom Page
