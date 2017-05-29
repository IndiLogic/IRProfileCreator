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

    TextBlueBigTitle {
        id:textTitle
        text: qsTr("What you want to do?")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 5
    }

    Item
    {
        id: item1
        anchors.top: textTitle.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 80


            StyledRadioButton {
                id:radioButtonChoice0
                text: qsTr("I want to create a new profile")
                checked: true
                displayHelpIcon: true
                helpText: qsTr("Help to be added.")

                onCheckedChanged: WizardState.wizardState.pageProfileCreationChoice.userChoice = 0

            }

            StyledRadioButton {
                text: qsTr("I want to modify an existing profile")
                displayHelpIcon: true
                helpText: qsTr("Help to be added.")

                onCheckedChanged: WizardState.wizardState.pageProfileCreationChoice.userChoice = 1

            }

            StyledRadioButton {
                text: qsTr("I want to create duplicate profile from existing profile")
                displayHelpIcon: true
                helpText: qsTr("Help to be added.")

                onCheckedChanged: WizardState.wizardState.pageProfileCreationChoice.userChoice = 2

            }

            StyledRadioButton {
                text: qsTr("I do not know what is profile. Please explain me")

                onCheckedChanged: WizardState.wizardState.pageProfileCreationChoice.userChoice = 3

            }

        }
    }

    function processNext()
    {
        console.log(WizardState.wizardState.pageProfileCreationChoice.pages[WizardState.wizardState.pageProfileCreationChoice.userChoice])
    }

    StackView.onStatusChanged: {

        if(StackView.status == StackView.Active)
            radioButtonChoice0.forceActiveFocus()
    }




}
