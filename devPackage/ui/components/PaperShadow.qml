import QtQuick 2.5
import QtGraphicalEffects 1.0

Item {
    id: control
    anchors.fill: parent
    state: "z-" + Math.max(0, Math.min(5, depth))

    property variant source
    property int depth: 0

    DropShadow {
        id: topShadow
        anchors.fill: parent
        source: control.source
        color: "#00000000"
        spread: 0.0
        samples: 32
        transparentBorder: true
        fast: true
    }

    DropShadow {
        id: bottomShadow
        anchors.fill: parent
        source: control.source
        color: "#00000000"
        spread: 0.0
        samples: 32
        transparentBorder: true
        fast: true
    }

    states: [
        State {
            name: "z-0"
            PropertyChanges { target: topShadow; verticalOffset: 0; radius: 0; color: "#00000000" }
            PropertyChanges { target: bottomShadow; verticalOffset: 0; radius: 0; color: "#00000000" }
        },
        State {
            name: "z-1"
            PropertyChanges { target: topShadow; verticalOffset: 1 ; radius: 1.5 ; color: "#1e000000" }
            PropertyChanges { target: bottomShadow; verticalOffset: 1 ; radius: 1 ; color: "#3d000000" }
        },
        State {
            name: "z-2"
            PropertyChanges { target: topShadow; verticalOffset: 3 ; radius: 3 ; color: "#28000000" }
            PropertyChanges { target: bottomShadow; verticalOffset: 3 ; radius: 3 ; color: "#3a000000" }
        },
        State {
            name: "z-3"
            PropertyChanges { target: topShadow; verticalOffset: 10 ; radius: 10 ; color: "#30000000" }
            PropertyChanges { target: bottomShadow; verticalOffset: 6 ; radius: 3 ; color: "#3a000000" }
        },
        State {
            name: "z-4"
            PropertyChanges { target: topShadow; verticalOffset: 14 ; radius: 14 ; color: "#40000000" }
            PropertyChanges { target: bottomShadow; verticalOffset: 10 ; radius: 5 ; color: "#38000000" }
        },
        State {
            name: "z-5"
            PropertyChanges { target: topShadow; verticalOffset: 19 ; radius: 19 ; color: "#4c000000" }
            PropertyChanges { target: bottomShadow; verticalOffset: 15 ; radius: 6 ; color: "#38000000" }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation {
                targets: [topShadow, bottomShadow]
                properties: "verticalOffset,radius"
                duration: 280
                easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
            }
            ColorAnimation {
                targets: [topShadow, bottomShadow]
                duration: 280
            }
        }
    ]
}
