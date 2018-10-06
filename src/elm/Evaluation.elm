module Evaluation exposing (Evaluation, decoder, encode)

import Json.Decode as Decode
import Json.Encode as Encode


type alias Evaluation =
    { id : Int
    , questionnaireId : Int
    , status : String
    }


decoder : Decode.Decoder Evaluation
decoder =
    Decode.map3 Evaluation
        (Decode.field "evaluation_id" Decode.int)
        (Decode.field "questionnaire_id" Decode.int)
        (Decode.field "status" Decode.string)


encode : Evaluation -> Encode.Value
encode evaluation =
    Encode.object
        [ ( "id", Encode.int evaluation.id )
        , ( "status", Encode.string evaluation.status )
        ]
