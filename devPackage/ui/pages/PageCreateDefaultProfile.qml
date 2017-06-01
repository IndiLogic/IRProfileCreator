import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

import "../components"
import "../scripts/Utility.js" as Utility
import "../scripts/DeviceInfo.js" as DeviceInfo
import "../scripts/Settings.js" as Settings
import "../scripts/WizardState.js" as WizardState

PageBase {
    id: pageBase1

    displayHeader: true
    headerText: qsTr("Creating default profile")
    isNextAllow: textFiledProfileName.text.trim().length > 0

    ColumnLayout {
        parent: pageContentParent
        anchors.fill: parent
        anchors.margins: 5

        Item
        {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Column {
                id: column1
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 80

                StyledTextField {
                    id: textFiledProfileName
                    textFileWidth: 540
                    placeHoderText: qsTr("Enter default profile name")
                    helpText: qsTr("Help to be added.")
                    onTextChanged: WizardState.wizardState.pageCreateDefaultProfile.profileName = text
                }

                Row
                {
                    id: row1
                    spacing: 20

                    Image {
                        id:imageProfileIcon
                        height: 128
                        width : 128
                        sourceSize.height: 128 * scaleRation
                        sourceSize.width: 128 * scaleRation
                        source: "../resources/images/DefaultProfileIcon.svg"
                    }


                    RaisedButtonBlue {
                        text:qsTr("Update Profile Icon")
                        anchors.verticalCenter: parent.verticalCenter
                        activeFocusOnTab: true

                        onClicked:
                        {
                            fileDialogIconFileSelect.open()
                        }
                    }

                }


            }

        }

        TextWarning {
            id:textWarning
            text: 'You have "%1" as your default profile. Creating new default profile will make "%1" profile to none default. Remember only one default profile can exist per %2 device collection'
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            visible: true
            textWrapMode: Text.WordWrap
            textMaxWidth: parent.width - 100

        }
    }

    function processNext()
    {
        console.log(WizardState.wizardState.pageProfileCreationChoice.pages[WizardState.wizardState.pageProfileCreationChoice.userChoice])
    }

    StackView.onStatusChanged: {

        if(StackView.status == StackView.Activating)
        {
            textWarning.visible = false

            //
            // Give warning to user about default profile
            //
            for(var index in selectedDeviceCollection.profileService.profiles)
            {
                var profile = selectedDeviceCollection.profileService.profiles[index]

                //
                // Skip check for profile creator profile itself
                //
                if(profile.id !== selectedDeviceProfile.id && profile.isDefault)
                {

                    //: %1 is profile name and %2 is device name. %1 and %2 will replace at runtime
                    textWarning.text = qsTr('You have "%1" as your default profile. Creating new default profile will make "%1" profile to none default. Remember only one default profile can exist per %2 device collection').
                    arg(profile.name).
                    arg(DeviceInfo.deviceInfo.name)

                    textWarning.visible = true
                    break
                }
            }

        }
        else if(StackView.status == StackView.Active)
        {
            textFiledProfileName.text = ""
            imageProfileIcon.source = "../resources/images/DefaultProfileIcon.svg"

            textFiledProfileName.forceActiveFocus()
        }
    }

    FileDialog
    {
        id: fileDialogIconFileSelect
        visible: false
        selectMultiple: false
        title: "Select Icon File"
        nameFilters : [ "Image/Executable files (*.jpg *.png *.svg *.ico *.exe)"]

        onAccepted:
        {

            //
            // Icon file
            //
            WizardState.wizardState.pageCreateDefaultProfile.profileIconPath = Utility.getClenPath(fileDialogIconFileSelect.fileUrl.toString()).replace(/\//g, "\\")
            imageProfileIcon.source = "image://CustomImageProvider/" + WizardState.wizardState.pageCreateDefaultProfile.profileIconPath
        }
    }



}
