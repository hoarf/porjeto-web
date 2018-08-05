module Config exposing (..)

import Material


type alias Config =
    { mdl : Material.Model }


default : Config
default =
    { mdl = Material.model
    }
