module Answer exposing (Answer, decoder, update)

import Json.Decode as Decode


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
        (Decode.field "description" Decode.string)
        (Decode.succeed False)
