module Components.LaunchesItem exposing (view)

import Html exposing (..)
import Html.Events exposing (onClick)
import Components.DateHelpers as DateHelpers
import Launches.Models exposing (Launches, Launch, LaunchId, Mission)
import Launches.Messages exposing (Msg(..))
import Components.Copy exposing (copy)


renderButtonNav : Launch -> Html Msg
renderButtonNav launch =
    div []
        [ button [ onClick (ShowPrevLaunch launch.id) ] [ text "Previous" ]
        , button [ onClick (ShowNextLaunch launch.id) ] [ text "Next" ]
        ]


renderMissionDescriptions : Mission -> Html Msg
renderMissionDescriptions mission =
    li [] [ text mission.description ]


view : Maybe Launch -> Html Msg
view launch =
    case launch of
        Nothing ->
            div [] [ text copy.launchInactive ]

        Just l ->
            div []
                [ renderButtonNav l
                , h2 [] [ DateHelpers.dateHeading l.isoStart ]
                , p [] [ text l.location.name ]
                , h1 [] [ text l.name ]
                , div [] [ DateHelpers.launchWindow l.wsstamp l.westamp ]
                , div [] [ DateHelpers.launchTime l.isoStart ]
                , ul []
                    (List.map renderMissionDescriptions l.missions)
                , hr [] []
                , p [] [ text (toString launch) ]
                ]