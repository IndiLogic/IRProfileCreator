import QtQuick 2.7
import QtQuick.Controls 2.0

import "../components"
import "../scripts/DeviceInfo.js" as DeviceInfo
import "../scripts/Settings.js" as Settings

PageBase {


    TextWarning {
        //: %1 is device name. %1 will replace at runtime
        text: qsTr("Make sure your %1 stay connected while working with wizard").arg(DeviceInfo.deviceInfo.name)
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Column{
        parent: pageContentParent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 50

        Column{
            TextBlueBigTitle{
                //: %1 is device name. %1 will replace at runtime
                text: qsTr("Welcome to profile creator for %1").arg(DeviceInfo.deviceInfo.name)
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
