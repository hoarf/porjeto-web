module EmailInput exposing (EmailInput, default, encode, isInvalid, updateValidation)

import Json.Encode as Encode
import Regex exposing (..)


type alias EmailInput =
    { input : String
    , validation : Maybe String
    }


isInvalid : EmailInput -> Bool
isInvalid email =
    not <| Regex.contains validEmail email.input


validEmail : Regex
validEmail =
    Regex.regex "^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        |> Regex.caseInsensitive


encode : EmailInput -> Encode.Value
encode email =
    Encode.object
        [ ( "email", Encode.string email.input ) ]


default : String -> EmailInput
default email =
    { input = email
    , validation = Nothing
    }


updateValidation : EmailInput -> String -> EmailInput
updateValidation email validation =
    case String.uncons validation of
        Just something ->
            { email | validation = Just validation }

        Nothing ->
            { email | validation = Nothing }
