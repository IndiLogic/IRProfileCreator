import QtQuick 2.7
import QtQuick.Controls 2.0
import "../components"
import "../scripts/DeviceInfo.js" as DeviceInfo
import "../scripts/Settings.js" as Settings
import "../scripts/WizardState.js" as WizardState

PageBase {
    id: pageBase1



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

    FontAwesome {
        id: fontAwesome
    }

    TextBlueBigTitle {
        id:textTitle
        text: qsTr("What type of profile do you want to create?")
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 5
        visible: false
    }

    Item
    {
        id: item1
        anchors.top: textTitle.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            spacing: 20

            TextWhiteBigTitle {
                font.family: "FontAwesome"
                text: fontAwesome.icons.fa_wrench
                font.pixelSize: 50
                anchors.verticalCenter: parent.verticalCenter
            }

            TextRedBigTitle {
                text: qsTr("Coming soon... Work in progress")
            }
        }

        Row
        {
            id: row1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 30
            spacing: 11
            visible: false

            TextWhiteSmall {
                text: qsTr("Click on")
            }

            TextWhiteSmall {
                font.family: "FontAwesome"
                text: fontAwesome.icons.fa_question_circle
                anchors.verticalCenter: parent.verticalCenter
            }

            TextWhiteSmall {
                text: qsTr("icon next to options for more help")
            }
        }

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 80
            visible: false


            StyledRadioButton {
                id:radioButtonChoice0
                text: qsTr("I want to create a default profile")
                checked: true
                displayHelpIcon: true
                helpText: qsTr("Help to be added.")

                onCheckedChanged: WizardState.wizardState.pageCreateNewProfile.userChoice = 0

            }

            StyledRadioButton {
                text: qsTr("I want to create profile for application or game")
                displayHelpIcon: true
                helpText: qsTr("Help to be added.")

                onCheckedChanged: WizardState.wizardState.pageCreateNewProfile.userChoice = 1

            }

        }
    }

    function processNext()
    {
        console.log(WizardState.wizardState.pageProfileCreationChoice.pages[WizardState.wizardState.pageProfileCreationChoice.userChoice])
    }

    StackView.onStatusChanged: {

        if(StackView.status == StackView.Active) {
            radioButtonChoice0.checked = false
            radioButtonChoice0.checked = true
            radioButtonChoice0.forceActiveFocus()
        }
    }




}
