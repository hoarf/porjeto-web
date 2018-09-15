module Answer exposing (Answer, decoder, update)

import Json.Decode as Decode
import Json.Encode as Encode


update : Answer -> Bool -> Answer
update answer value =
    { answer | value = value }


type alias Answer =
    { description : String
    , value : Bool
    }


decoder : Decode.Decoder Answer
decoder =
    Decode.map2 Answer
        Decode.string
        (Decode.succeed False)


encode : Answer -> Encode.Value
encode answer =
    Encode.object
        [ ( "answer1", Encode.bool answer.value ) ]
