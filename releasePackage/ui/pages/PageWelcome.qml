import QtQuick 2.7
import QtQuick.Controls 2.0

import "../components"
import "../scripts/DeviceInfo.js" as DeviceInfo
import "../scripts/Settings.js" as Settings

PageBase {

    /*Rectangle {
        //
        // We need to swap width and height becuase we rotated rectangle
        // to get gradient horizontal
        //
        width : parent.height
        height: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        rotation: 90
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#091224"
            }

            GradientStop {
                position: 0.299
                color: "#0f2943"
            }

            GradientStop {
                position: 0.701
                color: "#0f2943"
            }

            GradientStop {
                position: 1
                color: "#091224"
            }
        }
    }*/

    TextWarning {
        text: qsTr("Make sure your") + " " + DeviceInfo.deviceInfo.name + " "  + qsTr("stay connected while working with wizard")
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Column{

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 50

        Column{
            TextBlueBigTitle{
                text: qsTr("Welcome to profile creator for") + " " + DeviceInfo.deviceInfo.name
                anchors.horizontalCenter: parent.horizontalCenter
            }

            TextBlueMedium {
                text: qsTr("Profile creator wizard will help you to create new or update existing profile")
                anchors.horizontalCenter: parent.horizontalCenter
            }

            TextBlueMedium {
                text: qsTr('Please click "Next" to continue')
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }



        StyledCheckBox {
            id:checkBoxWelcomePageChoice
            text : qsTr("Never show this page again instead go to next page")
            anchors.horizontalCenter: parent.horizontalCenter
            onCheckedChanged: Settings.setShowWelcomePage(!checked)

        }
    }

    function processNext()
    {
        StackView.view.replace( Qt.resolvedUrl("PageProfileCreationChoice.qml"))
    }

    StackView.onStatusChanged: {

        if(StackView.status == StackView.Active)
            checkBoxWelcomePageChoice.forceActiveFocus()
    }



}
