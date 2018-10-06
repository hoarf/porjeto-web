module Evaluation exposing (Evaluation, decoder, encode)

import Json.Decode as Decode
import Json.Encode as Encode


type alias Evaluation =
    { id : Int
    , questionnaireId : Int
    }


decoder : Decode.Decoder Evaluation
decoder =
    Decode.map2 Evaluation
        (Decode.field "evaluation_id" Decode.int)
        (Decode.field "questionnaire_id" Decode.int)


encode : Evaluation -> Encode.Value
encode evaluation =
    Encode.object
        [ ( "id", Encode.int evaluation.id ) ]
