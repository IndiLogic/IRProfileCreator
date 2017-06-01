import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import "../popups"

Item
{

    anchors.fill: parent
    readonly property var stackView: stackViewMain

    FontAwesome {
        id: fontAwesome
    }

    Row {
        spacing: 15
        anchors.right: parent.right

        RaisedButtonBlue {
            useFontAwesome: true
            text: fontAwesome.icons.fa_download
            visible: useDevPackage
            activeFocusOnTab: true

            onClicked: fourceUpdate(true)
        }

        RaisedButtonBlue {
            useFontAwesome: true
            text: fontAwesome.icons.fa_cog
            activeFocusOnTab: true

            onClicked: popupSettings.open()
        }

    }

    ColumnLayout
    {
        spacing: 10
        anchors.fill: parent




        TextBlueMedium {
            //: %1 is device name. %1 will replace at runtime
            text: (stackViewMain.deviceName.length > 0 ? qsTr("InputRedirection Profile Creator for %1").arg(stackViewMain.deviceName) : qsTr("InputRedirection Profile Creator")) + " (" + packageManager.version + ")"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        }

        Rectangle {

            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "#00000000"
            radius: 8
            border.width: 2
            border.color: "white"

            StackView {
                id:stackViewMain
                anchors.fill: parent
                anchors.margins: (parent.border.width / 2) + (4 )
                clip: true
                focus: true

                property string deviceName: ""

                pushEnter: Transition {
                    PropertyAnimation {
                        property: "x"
                        from: width
                        to: 0
                        duration: 200
                    }
                }
                pushExit: Transition {
                    PropertyAnimation {
                        property: "x"
                        from: 0
                        to: -width
                        duration: 200
                    }
                }
                popEnter: Transition {
                    PropertyAnimation {
                        property: "x"
                        from: -width
                        to: 0
                        duration: 200
                    }
                }
                popExit: Transition {
                    PropertyAnimation {
                        property: "x"
                        from: 0
                        to: width
                        duration: 200
                    }
                }
                replaceEnter: Transition {
                    PropertyAnimation {
                        property: "x"
                        from: -width
                        to: 0
                        duration: 200
                    }
                }
                replaceExit: Transition {
                    PropertyAnimation {
                        property: "x"
                        from: 0
                        to: width
                        duration: 200
                    }
                }


            }

        }

        Row {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: false
            spacing: 20

            RaisedButtonGreen {
                id:buttonNext
                text: stackViewMain.currentItem ? stackViewMain.currentItem.nextText : qsTr("Next")
                enabled: (stackViewMain.currentItem ? stackViewMain.currentItem.isNextAllow : true)
                widthPadding: 40

                onClicked:stackViewMain.currentItem.processNext()
            }

            RaisedButtonGreen {
                id:buttonBack
                text: qsTr("Back")
                enabled:  stackViewMain.depth > 1 && (stackViewMain.currentItem ? stackViewMain.currentItem.isBackAllow : true)
                widthPadding: 40

                onClicked: stackViewMain.pop()
            }

            RaisedButtonRed {
                id:buttonCancel
                text: stackViewMain.depth > 1 ? qsTr("Cancel") : qsTr("Close")
                enabled: stackViewMain.currentItem ? stackViewMain.currentItem.isCancleAllow : true
                widthPadding: 40

                onClicked: stackViewMain.depth > 1 ? stackViewMain.pop(null) : close()

            }

        }
    }

    PopupSettings {
        id: popupSettings
    }


}
