import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.2

import "components"
import "scripts/DeviceInfo.js" as DeviceInfo
import "scripts/Settings.js" as Settings


/*Window {

    width: 1920
    height: 1080
    visible: true

    Rectangle {
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

    Item {
        id: launchRootItem
        anchors.fill: parent
        anchors.margins: 10

        StackViewBase {
            id: rootStackView
            anchors.fill: parent
        }


        CheckUpdate{
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
        }

        Component.onCompleted: {

            Settings.initialize(packageManager)
            DeviceInfo.initialize(selectedDeviceCollection)

            if(DeviceInfo.deviceInfo.isSupported) {

                rootStackView.stackView.deviceName = DeviceInfo.deviceInfo.name

                if(Settings.showWelcomePage())
                    rootStackView.stackView.push( Qt.resolvedUrl("pages/PageWelcome.qml"))
                else
                    rootStackView.stackView.push( Qt.resolvedUrl("pages/PageProfileCreationChoice.qml"))

            } else {

                rootStackView.stackView.push( Qt.resolvedUrl("pages/PageGenericError.qml"), {
                                                 errorString:qsTr("This device not yet supported by profile creator")
                                             })

            }

        }

        FileDialog
        {
            id: fileDialogDummy // FileDialog load can take some time so we put on launh.qml so other pages load faster
            visible: false
            selectMultiple: false
        }
    }
//}
