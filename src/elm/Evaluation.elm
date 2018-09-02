module Evaluation exposing (decoder)

import Json.Decode as Decode


type alias Evaluation =
    { userId : Int
    , questionnaireId : Int
    }


decoder : Decode.Decodr Evaluation
decoder =
    Decode.map2 Evaluation
        (Decode.field "user_id" Decode.int)
        (Decode.field "questionnaire_id" Decode.int)
