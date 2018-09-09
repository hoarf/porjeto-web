module User exposing (User, default)

import Json.Encode as Encode
import Regex exposing (Regex)


type alias User =
    { email : String
    }


default : User
default =
    { email = ""
    }
