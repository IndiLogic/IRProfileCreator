import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import "../components"
import "../scripts/DeviceInfo.js" as DeviceInfo
import "../scripts/Settings.js" as Settings
import "../scripts/WizardState.js" as WizardState

PageBase {
    id: pageBase1

    displayHeader: true
    headerText: qsTr("What do you want to do?")

    Column {
        parent: pageContentParent
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
            text: qsTr("I want to duplicate profile from existing profile")
            displayHelpIcon: true
            helpText: qsTr("Help to be added.")

            onCheckedChanged: WizardState.wizardState.pageProfileCreationChoice.userChoice = 2

        }

        StyledRadioButton {
            text: qsTr("I do not know what is profile. Please explain me")

            onCheckedChanged: WizardState.wizardState.pageProfileCreationChoice.userChoice = 3

        }

    }





    function processNext()
    {
        StackView.view.push(Qt.resolvedUrl(WizardState.wizardState.pageProfileCreationChoice.pages[WizardState.wizardState.pageProfileCreationChoice.userChoice]))
    }

    StackView.onStatusChanged: {

        if(StackView.status == StackView.Active) {
            radioButtonChoice0.checked = false
            radioButtonChoice0.checked = true
            radioButtonChoice0.forceActiveFocus()
        }
    }




}
