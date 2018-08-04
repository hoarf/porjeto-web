module User exposing (User, default, isNotReady, updateEmail)

import Material
import Regex exposing (Regex)


type alias User =
    { email : String
    , mdl : Material.Model
    }


default : User
default =
    { email = ""
    , mdl = Material.model
    }


isInValid : User -> Bool
isInValid user =
    not <| Regex.contains validEmail user.email


isNotReady : User -> Bool
isNotReady user =
    isInValid user


updateEmail : String -> User -> User
updateEmail email user =
    { user | email = email }


validEmail : Regex
validEmail =
    Regex.regex "^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        |> Regex.caseInsensitive
