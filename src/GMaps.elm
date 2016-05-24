port module GMaps exposing (..)

import SharedModels exposing (GMPos)


-- PORTS

port moveMap : GMPos -> Cmd msg
