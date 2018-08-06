module Question exposing (Answer, Question, default, q1, updateAnswer)


type alias Answer =
    { description : String
    , value : Bool
    }


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
    , answer1 = Answer "I dunno" False
    , answer2 = Answer "A dumb one" False
    , answer3 = Answer "A retarded one" False
    , answer4 = Answer "A smart one" False
    , answer5 = Answer "Whatever dude" False
    , seconds = 0
    , order = 0
    }


q1 : Question
q1 =
    { default | order = 1 }


updateAnswer : Question -> Int -> Bool -> Question
updateAnswer question ix value =
    case ix of
        1 ->
            { question | answer1 = update question.answer1 value }

        2 ->
            { question | answer2 = update question.answer2 value }

        3 ->
            { question | answer3 = update question.answer3 value }

        4 ->
            { question | answer4 = update question.answer4 value }

        5 ->
            { question | answer5 = update question.answer5 value }

        _ ->
            question


update : Answer -> Bool -> Answer
update answer value =
    { answer | value = value }
