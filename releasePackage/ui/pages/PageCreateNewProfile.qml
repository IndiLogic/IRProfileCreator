import QtQuick 2.7
import QtQuick.Controls 2.0
import "../components"
import "../scripts/DeviceInfo.js" as DeviceInfo
import "../scripts/Settings.js" as Settings
import "../scripts/WizardState.js" as WizardState

PageBase {
    id: pageBase1


    displayHeader: true
    headerText: qsTr("What type of profile do you want to create?")

    Column {
        parent: pageContentParent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 80


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

    function processNext()
    {
        StackView.view.push(Qt.resolvedUrl(WizardState.wizardState.pageCreateNewProfile.pages[WizardState.wizardState.pageCreateNewProfile.userChoice]))
    }

    StackView.onStatusChanged: {

        if(StackView.status == StackView.Active) {
            radioButtonChoice0.checked = false
            radioButtonChoice0.checked = true
            radioButtonChoice0.forceActiveFocus()
        }
    }




}
