import QtQuick 2.7

FocusScope{

    id: control
    implicitWidth: row.width
    implicitHeight: row.height

    property bool displayHelpIcon : true
    property bool displayHelpIconRightSide : true
    property alias helpText: popupHelp.text
    property int textFileWidth: 200
    property int textFileHeight: 30
    property alias placeHoderText : textPlaceHodler.text
    property alias text : textInput.text
    property alias length : textInput.text
    property color activeBorderColor: "orange"

    activeFocusOnTab: true

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
            id:rectangleText
            width: control.textFileWidth + 12
            height: control.textFileHeight + 10
            radius: 3
            color: "white"
            border.width: textInput.activeFocus ? 3  : 2
            border.color: textInput.activeFocus ? activeBorderColor : "lightgray"

            TextInput {
                id:textInput
                anchors.fill: parent
                anchors.topMargin: 4
                anchors.bottomMargin: 4
                anchors.leftMargin: 6
                anchors.rightMargin: 6
                padding: 0
                clip: true
                font.family: textPlaceHodler.font.family
                font.pixelSize: height - 4
                activeFocusOnPress:true
                activeFocusOnTab: control.activeFocusOnTab
                selectByMouse: true
                focus: true
                verticalAlignment: TextInput.AlignVCenter

                TextWhiteMedium
                {
                    id:textPlaceHodler
                    anchors.fill: parent
                    color: "lightgray"
                    font.pixelSize: textInput.font.pixelSize
                    shadowColor: "gray"
                    text: "PlaceHoder"
                    visible: textInput.text.length == 0
                    fontSizeMode: Text.Fit

                }
            }


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


