import QtQuick 2.7
import QtQuick.Layouts 1.1
import "../components"
import "../scripts/Settings.js" as Settings


PopupContent {

    titleText: qsTr("Settings")

    contentItem: Item {

        width: 400
        height: 232


        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: false
            spacing: 50

            StyledCheckBox {
                id:checkBoxShowWelCome
                text: qsTr('Show Welcome page')
                KeyNavigation.backtab: closeButton

                onCheckedChanged: Settings.setShowWelcomePage(checked)

            }

            StyledCheckBox {
                id:checkBoxDeveloperMode
                text: qsTr('Enable developer mode')
                displayHelpIcon: true
                helpText: qsTr("Help to be added.")
                KeyNavigation.tab: closeButton

                onCheckedChanged: {
                    Settings.setDeveloperMode(checked)
                    useDevPackage = checked
                }
            }

        }

    }


    onVisibleChanged: {
        //
        // Only for this popup we have get setting this way becuase Settings is not initialize when this componenst created
        //
        if(visible)
        {
            checkBoxShowWelCome.checked = Settings.showWelcomePage()
            checkBoxDeveloperMode.checked = Settings.developerMode()
            checkBoxShowWelCome.forceActiveFocus()
        }
    }



}








