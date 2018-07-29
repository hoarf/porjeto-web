module User exposing (User, defaultUser)


type alias User =
    { email : String
    }


defaultUser : User
defaultUser =
    { email = "" }
