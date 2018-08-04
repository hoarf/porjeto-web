module Question exposing (Answer, Question, defaultQuestion)


type Answer
    = Answer String


type alias Question =
    { description : String
    , answer1 : Answer
    , answer2 : Answer
    , answer3 : Answer
    , answer4 : Answer
    , answer5 : Answer
    , selected : Maybe Answer
    , seconds : Int
    , order : Int
    }


defaultQuestion : Question
defaultQuestion =
    { description = "Sample Question"
    , answer1 = Answer ""
    , answer2 = Answer ""
    , answer3 = Answer ""
    , answer4 = Answer ""
    , answer5 = Answer ""
    , selected = Nothing
    , seconds = 0
    , order = 0
    }
