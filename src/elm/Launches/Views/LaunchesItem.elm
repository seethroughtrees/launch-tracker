module Launches.Views.LaunchesItem exposing (view)

import Html exposing (..)
import Html.Events exposing (onClick)
import Components.DateHelpers as DateHelpers
import Launches.Models exposing (Launches, Launch, LaunchId, Mission, LaunchMenu)
import Launches.Messages exposing (Msg(..))
import Components.Copy exposing (copy)
import Launches.Views.LaunchesMenu as LaunchesMenu
import Components.Buttons as Button exposing (Btn)


renderButtonNav : Launch -> Html Msg
renderButtonNav launch =
    div []
        [ button [ onClick (ShowPrevLaunch launch.id) ] [ text "Previous" ]
        , button [ onClick (ShowNextLaunch launch.id) ] [ text "Next" ]
        ]


watchButton : Btn
watchButton =
    Btn
        copy.watchLaunch
        Button.Large
        Button.Primary
        Button.Watch


alarmButton : Launch -> Btn
alarmButton launch =
    let
        text =
            toString (DateHelpers.launchTime launch.isoStart)
    in
        Btn
            (DateHelpers.launchTime launch.isoStart)
            Button.Small
            Button.Secondary
            Button.Alarm


renderMissionDescriptions : Mission -> Html Msg
renderMissionDescriptions mission =
    li [] [ text mission.description ]


view : LaunchMenu -> Maybe Launch -> Html Msg
view menu launch =
    case launch of
        Nothing ->
            div [] [ text copy.launchInactive ]

        Just l ->
            div []
                [ renderButtonNav l
                , h2 [] [ text (DateHelpers.dateHeading l.isoStart) ]
                , p [] [ text l.location.name ]
                , h1 [] [ text l.name ]
                , div [] [ DateHelpers.launchWindow l.wsstamp l.westamp ]
                , p [] [ Button.view (alarmButton l) ]
                , LaunchesMenu.view menu l
                , ul []
                    (List.map renderMissionDescriptions l.missions)
                , Button.view watchButton
                , hr [] []
                , p [] [ text (toString launch) ]
                ]
