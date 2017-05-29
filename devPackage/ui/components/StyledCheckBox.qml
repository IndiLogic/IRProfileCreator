import QtQuick 2.7
import QtQuick.Controls 2.0

CheckBox {

    id: control
    width: row.width
    height: row.height

    text : "StyledCheckBox"

    property bool displayHelpIcon : false
    property bool displayHelpIconRightSide : true
    property alias helpText: popupHelp.text

    indicator : Item{}
    contentItem: Item{}

    FontAwesome {
        id: fontAwesome
    }


    Row {
        id:row
        spacing: 15

        TextWhiteSmall {
            font.family: "FontAwesome"
            text: fontAwesome.icons.fa_question_circle
            color: leftHelpMuseArea.containsMouse ? "lightgray" : "white"
            visible: displayHelpIcon && !displayHelpIconRightSide

            MouseArea {
                id: leftHelpMuseArea
                anchors.fill: parent
                hoverEnabled: true

                onClicked:
                {
                    mouse.accepted = true
                    popupHelp.open()
                }


            }
        }

        Rectangle {
            width: 32
            height: width
            radius: 4
            anchors.verticalCenter: parent.verticalCenter
            border.width: control.activeFocus ? 3  : 2
            border.color: control.activeFocus ? "#ff02BEE2" : "lightgray"

            Rectangle {
                id: rectangleCheck
                anchors.fill: parent
                anchors.margins: 5
                radius: 4
                color: "green"
                visible: control.checked
            }
        }

        TextWhiteMedium {
            text : control.text
        }

        TextWhiteSmall {
            font.family: "FontAwesome"
            text: fontAwesome.icons.fa_question_circle
            color: rightHelpMuseArea.containsMouse ? "lightgray" : "white"
            visible: displayHelpIcon && displayHelpIconRightSide

            MouseArea {
                id: rightHelpMuseArea
                anchors.fill: parent
                hoverEnabled: true

                onClicked:
                {
                    mouse.accepted = true
                    popupHelp.open()
                }


            }
        }

    }

    PopupGeneric {
        id:popupHelp
    }

}


