import QtQuick 2.7
import QtQuick.Controls 2.0

RadioButton  {

    id: control
    width: row.width
    height: row.height

    text : "StyledRadioButton"

    property bool displayHelpIcon : false
    property bool displayHelpIconRightSide : true
    property alias helpText: popupHelp.text
    property color activeBorderColor: "orange"

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
            radius: width /2
            anchors.verticalCenter: parent.verticalCenter
            border.width: control.activeFocus ? 3  : 2 
            border.color: control.activeFocus ? activeBorderColor : "lightgray"

            Rectangle {
                id: rectangleCheck
                anchors.fill: parent
                anchors.margins: 5 
                radius: width/2
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



