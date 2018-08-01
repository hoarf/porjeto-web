module Types exposing (..)


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
