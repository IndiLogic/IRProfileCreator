import QtQuick 2.7
import QtQuick.Layouts 1.1
import "../scripts/Utility.js" as Utility


Rectangle {
    id:root
    height: column.height + (40 )
    width: column.width + (40 )
    color: "#E0E0f914"
    radius: 18
    border.width: 4
    border.color: "white"
    opacity: 0.0
    visible: opacity > 0.0

    property var request: null
    property var requestAbortTimer : null

    FontAwesome {
        id: fontAwesome
    }

    Column {
        id: column
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10

        RaisedButtonRed {
            id:buttonClose
            useFontAwesome:true
            text:fontAwesome.icons.fa_times
            anchors.right: parent.right
            anchors.rightMargin: 5

            onClicked: close()
        }

        StyledBusyIndicator {
            id:busyIndicator
            width:  45
            height: 45
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            visible: parent.visible

        }


        ColumnLayout {
            spacing: 0

            TextBlackMedium {
                id: mainText
                text:qsTr("Checking for update...")
                shadowEnable: false
                wrapMode: Text.WordWrap
                Layout.maximumWidth: 550

            }
        }

        RaisedButtonGreen {
            id:buttonUpdate
            text:qsTr("Update Now")
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false

            onClicked: fourceUpdate(true)
        }


    }


    Behavior on opacity {
        SmoothedAnimation { velocity: 0.1; duration: 1500 }
    }


    Component.onCompleted: {

        opacity = 1.0

        request = new XMLHttpRequest();

        requestAbortTimer = Qt.createQmlObject("import QtQuick 2.7; Timer {interval: 10000; repeat: false; running: true;}",root,"requestAbortTimer");
        requestAbortTimer.triggered.connect(updateCheckTimeOut);


        request.open("GET",packageInfoFileSource,true);
        request.onreadystatechange = function() {

            if (request.readyState === XMLHttpRequest.DONE && request.status == 200) {

                parseUpdateData()

            }else if (request.readyState === XMLHttpRequest.DONE && request.status != 200) {
                updateCheckFailed()
            }
        }

        request.send();

    }

    function updateCheckFailed() {

        requestAbortTimer.running = false
        busyIndicator.visible = false
        mainText.text = qsTr("Checking for update failed!")

    }

    function updateCheckTimeOut() {

        request.abort();
        requestAbortTimer.running = false
        busyIndicator.visible = false
        mainText.text = qsTr("Unable to connect to update server!")

    }

    function parseUpdateData() {

        busyIndicator.visible = false
        requestAbortTimer.running = false

        var packageInfoObject = JSON.parse(request.responseText)

        if(Utility.compareVersions(packageInfoObject.info.version,">",packageManager.version))
        {
            //
            // New update is available but lest check required minimum IndiController Version
            //
            console.log(packageInfoObject.info.minimumICVersion)
            console.log(packageManager.icVersion)
            if(Utility.compareVersions(packageInfoObject.info.minimumICVersion,">",packageManager.icVersion))
            {
                //
                // Ask user to update to latest version of IndiController
                //
                mainText.text = qsTr("New update") +
                        " " +
                        packageInfoObject.info.version +
                        " " +
                        qsTr("is available but new update rquires IndiController version") +
                        " " +
                        packageInfoObject.info.minimumICVersion +
                        " " +
                        qsTr("and you have installed version") +
                        " " +
                        packageManager.icVersion +
                        " " +
                        qsTr(". Please update IndiController to latest version.")

            }
            else
            {
                mainText.text = qsTr("New update") + " " + packageInfoObject.info.version + " " + qsTr("is available. Do you want to update?")
                buttonUpdate.visible = true
            }
        }
        else
        {
            close()
        }
    }

    function close() {

        request.abort()
        root.opacity = 0.0


    }


}

