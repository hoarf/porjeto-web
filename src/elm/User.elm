module User exposing (User, default, encode, isNotReady, isReady, updateEmail)

import Json.Encode as Encode
import Regex exposing (Regex)


type alias User =
    { email : String
    }


default : User
default =
    { email = ""
    }


isInvalid : User -> Bool
isInvalid user =
    not <| Regex.contains validEmail user.email


isNotReady : Maybe User -> Bool
isNotReady user =
    user
        |> Maybe.map (\u -> True)
        |> Maybe.withDefault False


isReady : User -> Bool
isReady user =
    user
        |> isInvalid
        |> not


updateEmail : String -> User -> User
updateEmail email user =
    { user | email = email }


validEmail : Regex
validEmail =
    Regex.regex "^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        |> Regex.caseInsensitive


encode : User -> Encode.Value
encode user =
    Encode.object
        [ ( "email", Encode.string user.email ) ]
