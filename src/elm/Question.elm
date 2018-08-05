module Question exposing (Answer(..), Question, default, q1)


type Answer
    = Answer String


type alias Question =
    { description : String
    , answer1 : Answer
    , answer2 : Answer
    , answer3 : Answer
    , answer4 : Answer
    , answer5 : Answer
    , seconds : Int
    , order : Int
    }


default : Question
default =
    { description = "What kind of question is this?"
    , answer1 = Answer "I dunno"
    , answer2 = Answer "A dumb one"
    , answer3 = Answer "A retarded one"
    , answer4 = Answer "A smart one"
    , answer5 = Answer "Whatever dude"
    , seconds = 0
    , order = 0
    }


q1 : Question
q1 =
    { default | order = 1 }
