module User exposing (User, default)


type alias User =
    { email : String
    }


default : User
default =
    { email = ""
    }
