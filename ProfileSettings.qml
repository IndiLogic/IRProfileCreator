import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import IndiController 1.0 // comment out this while editing else QML editor will not work also at runtime must required


//
// Copy/Paste whole this QML code in "Profile Settings QML"
// Do not use any other componets except Qt's built-in or created in this file
//

Window {
    id: mainRootWindow
    visible: true
    width: 1920
    height: 1080
    title: qsTr("InpuRediraction Profile Creator")

    property bool isUpdate : false
    property bool useDevPackage: false // Enable disbale developer mode

    readonly property double scaleRation: Math.min(mainRootWindow.width/1920,mainRootWindow.height/1080)
    readonly property string packageSource: "https://raw.githubusercontent.com/IndiLogic/IRProfileCreator/master/" + (useDevPackage ? "devPackage" : "releasePackage") // package server URL
    readonly property string packageInfoFileSource: packageSource + "/packageInfo.json" // package info file server URL


    //
    // Background color for whole window
    //
    Rectangle {
        //
        // We need to swap width and height becuase we rotated rectangle
        // to get gradient horizontal
        //
        width : parent.height
        height: parent.width
        anchors.centerIn: parent

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

    }

    Item {
        width:1920
        height:1080

        transform: [
            Scale {
                id: scale; xScale: yScale;
                yScale: Math.min(
                            mainRootWindow.width/1920,
                            mainRootWindow.height/1080);},
            Translate {
                x: (mainRootWindow.width-1920*scale.xScale)/2;
                y: (mainRootWindow.height-1080*scale.yScale)/2;}]


        Item {
            anchors.fill: parent

            Loader {

                id:mainRootLoader
                anchors.fill: parent
                active: packageManager.state == PackageManager.StateReady
                asynchronous: true
                visible: status == Loader.Ready

            }

        }

        Item {
            id: mainRootItem
            anchors.fill: parent
            anchors.margins: 20
            visible: mainRootLoader.status !== Loader.Ready



            ColumnLayout {
                width: 1920

                Text {

                    text: qsTr("Welcome To InputRedirection Profile Creator") + (packageManager.state == PackageManager.StateReady ? " (" + packageManager.version + ")" : "")
                    Layout.fillHeight: false
                    font.family: "Segoe UI"
                    color: "#ff02BEE2"
                    font.pixelSize: 50
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillWidth: true
                }

                Text {
                    id:textPackageMangerState
                    text: qsTr("Initializing Package. Please Wait...")
                    Layout.fillHeight: false
                    font.family: "Segoe UI"
                    color: "white"
                    font.pixelSize: 32
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillWidth: true

                }

            }



            Text {
                id:textPackageMangerErrorInfo
                text: ""
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Segoe UI"
                color: "red"
                font.pixelSize: 40
                visible: packageManager.state == PackageManager.StateError

            }

            Text {
                id:textPackageMangerDownloadRequired
                text: qsTr("To processd, you must have to download package.")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Segoe UI"
                color: "yellow"
                font.pixelSize: 40
                visible: packageManager.state == PackageManager.StatePackageDownloadRequired

            }

            Button {
                id: buttonDownload
                text: qsTr("Start Download")
                bottomPadding: 6
                rightPadding: 8
                leftPadding: 8
                topPadding: 6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: textPackageMangerDownloadRequired.bottom
                anchors.topMargin: 30
                font.family: "Segoe UI"
                font.pixelSize: 20
                font.bold: true
                height: 70
                visible: packageManager.state == PackageManager.StatePackageDownloadRequired

                onClicked: packageManager.initialize()

            }

            Text {
                id:textPackageMangerDownloadFileName
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Downloading") + " : " + packageManager.downloadingSource
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Segoe UI"
                color: "yellow"
                font.pixelSize: 40
                width: parent.width - (20 )
                wrapMode: Text.WordWrap
                visible: packageManager.state == PackageManager.StateDownloading

            }

            Row {

                spacing: 20
                anchors.top: textPackageMangerDownloadFileName.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                visible: packageManager.state == PackageManager.StateDownloading

                Text {
                    id:textPackageMangerDownloadProgress
                    text: qsTr("Download Progress") + " : "
                    font.family: "Segoe UI"
                    color: "yellow"
                    font.pixelSize: 40
                    visible: packageManager.state == PackageManager.StateDownloading

                }

                ProgressBar {
                    id:progressBarDownloadProgress
                    value: packageManager.downloadingProgress
                    width: 250
                    anchors.verticalCenterOffset: 4
                    anchors.verticalCenter: parent.verticalCenter
                    visible: packageManager.state == PackageManager.StateDownloading

                }
            }

            Text {
                id:textPackageMangerDownloadFailedFileName
                text: qsTr("Downloading Failed ") + " : " + packageManager.downloadingSource
                horizontalAlignment: Text.AlignHCenter
                anchors.top: textPackageMangerErrorInfo.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Segoe UI"
                color: "red"
                font.pixelSize: 40
                width: parent.width - (20 )
                wrapMode: Text.WordWrap
                visible: packageManager.state == PackageManager.StateError && packageManager.error == PackageManager.ErrorDownloading

            }

            Text {
                id:textPackageMangerDownloadFailedErrorCode
                text: qsTr("Error Code") + " : " + packageManager.errorCode
                anchors.top: textPackageMangerDownloadFailedFileName.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Segoe UI"
                color: "red"
                font.pixelSize: 40
                visible: packageManager.state == PackageManager.StateError && packageManager.error == PackageManager.ErrorDownloading

            }

            Text {
                id:textPackageMangerDownloadFailedErrorString
                text: qsTr("Error") + " : " + packageManager.errorString
                horizontalAlignment: Text.AlignHCenter
                anchors.top: textPackageMangerDownloadFailedErrorCode.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Segoe UI"
                color: "red"
                font.pixelSize: 40
                width: parent.width - (20 )
                wrapMode: Text.WordWrap
                visible: packageManager.state == PackageManager.StateError && packageManager.error == PackageManager.ErrorDownloading

            }

            Button {
                id: buttonRetryDownload
                text: !isUpdate ? qsTr("Try Again") : qsTr("Launch old interface")
                bottomPadding: 6
                rightPadding: 8
                leftPadding: 8
                topPadding: 6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: textPackageMangerDownloadFailedErrorString.bottom
                anchors.topMargin: 30
                font.family: "Segoe UI"
                font.pixelSize: 20
                font.bold: true
                height: 70
                visible: packageManager.state == PackageManager.StateError && packageManager.error == PackageManager.ErrorDownloading

                onClicked: packageManager.initialize()

            }

            Text {
                id:textPackageMangerGenericErrorCode
                text: qsTr("Error Code") + " : " + packageManager.errorCode
                anchors.top: textPackageMangerErrorInfo.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Segoe UI"
                color: "red"
                font.pixelSize: 40
                visible: packageManager.state == PackageManager.StateError && (packageManager.error == PackageManager.ErrorInvalidPackageInfo || packageManager.error == PackageManager.ErrorCopy)

            }

            Text {
                id:textPackageMangerGenericErrorString
                text: qsTr("Error") + " : " + packageManager.errorString
                horizontalAlignment: Text.AlignHCenter
                anchors.top: textPackageMangerGenericErrorCode.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Segoe UI"
                color: "red"
                font.pixelSize: 40
                width: parent.width - (20 )
                wrapMode: Text.WordWrap
                visible: packageManager.state == PackageManager.StateError && (packageManager.error == PackageManager.ErrorInvalidPackageInfo || packageManager.error == PackageManager.ErrorCopy)

            }



            Row {
                spacing: 20
                anchors.top: textPackageMangerDownloadFileName.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                visible: packageManager.state == PackageManager.StateCopyfile

                Text {
                    id:textPackageMangerCopyProgress
                    text: qsTr("File Copy Progress") + " : "
                    font.family: "Segoe UI"
                    color: "yellow"
                    font.pixelSize: 40
                    visible: packageManager.state == PackageManager.StateCopyfile

                }

                ProgressBar {
                    id:progressBarCopyProgress
                    value: packageManager.downloadingProgress
                    width: 250
                    anchors.verticalCenterOffset: 4
                    anchors.verticalCenter: parent.verticalCenter
                    visible: packageManager.state == PackageManager.StateCopyfile

                }
            }

            BusyIndicator {

                id: busyIndicatorLaunchingInterface
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                visible: packageManager.state == PackageManager.StateReady && (mainRootLoader.status != Loader.Ready && mainRootLoader.status != Loader.Error)

                contentItem: Item {
                    implicitWidth: 120
                    implicitHeight: 120

                    Item {
                        id: item
                        x: parent.width / 2  - (60 )
                        y: parent.height / 2  - (60 )
                        width: 120
                        height: 120
                        opacity: busyIndicatorLaunchingInterface.running ? 1 : 0

                        Behavior on opacity {
                            OpacityAnimator {
                                duration: 250
                            }
                        }

                        RotationAnimator {
                            target: item
                            running: busyIndicatorLaunchingInterface.visible && busyIndicatorLaunchingInterface.running
                            from: 0
                            to: 360
                            loops: Animation.Infinite
                            duration: 2000
                        }

                        Repeater {
                            id: repeater
                            model: 6

                            Rectangle {
                                x: item.width / 2  - width / 2
                                y: item.height / 2 - height / 2
                                implicitWidth: 10
                                implicitHeight: 10
                                radius: 5
                                color: "#ff02BEE2"
                                transform: [
                                    Translate {
                                        y: -Math.min(item.width, item.height) * (0.5 ) + (5 )
                                    },
                                    Rotation {
                                        angle: index / repeater.count * 360
                                        origin.x: 5
                                        origin.y: 5
                                    }
                                ]
                            }
                        }
                    }
                }

            }

            Text {
                id:textLoaderError
                text: qsTr("Unable to load the main interface")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Segoe UI"
                color: "red"
                font.pixelSize: 40
                visible: mainRootLoader.status == Loader.Error

            }

            Text {
                id:textLoaderErrorInfo
                text: qsTr("Try force downloaing again")
                anchors.top: textLoaderError.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Segoe UI"
                color: "yellow"
                font.pixelSize: 40
                visible: mainRootLoader.status == Loader.Error

            }


            Button {
                id: buttonDownloadAgain
                text: qsTr("Force Download Again")
                bottomPadding: 6
                rightPadding: 8
                leftPadding: 8
                topPadding: 6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: textLoaderErrorInfo.bottom
                anchors.topMargin: 30
                font.family: "Segoe UI"
                font.pixelSize: 20
                font.bold: true
                height: 70
                visible: mainRootLoader.status == Loader.Error

                onClicked: fourceUpdate(false)

            }



        }


    }






    Connections {
        target:packageManager
        onStateChanged: {

            if(packageManager.state == PackageManager.StateError) {

                textPackageMangerState.text = qsTr("Error occurred during initialization of package")

            } else if(packageManager.state == PackageManager.StateInitializing) {

                textPackageMangerState.text = qsTr("Initializing package. Please wait...")

            } else if(packageManager.state == PackageManager.StatePackageDownloadRequired) {

                if(isUpdate) {
                    textPackageMangerState.text = qsTr("Package download require for update")
                    textPackageMangerDownloadRequired.text = qsTr("Update to latest verion, you must have to download new package.")
                }
                else
                    textPackageMangerState.text = qsTr("Package download require")


            } else if(packageManager.state == PackageManager.StateDownloading) {

                textPackageMangerState.text = qsTr("Downloading package files. Please wait...")

            } else if(packageManager.state == PackageManager.StateCopyfile) {

                textPackageMangerState.text = qsTr("Copying package files. Please wait...")

            } else if(packageManager.state == PackageManager.StateReady) {

                textPackageMangerState.text = qsTr('Launching interface. Please wait...')
                mainRootLoader.source = "file:///" + packageManager.packageDir + "/ui/Launch.qml" // lauch from downloaded package

            }

        }
        onErrorChanged: {

            if(packageManager.error == PackageManager.ErrorPackageSource) {

                textPackageMangerErrorInfo.text = qsTr("Package source is not valid")

            } else if(packageManager.error == PackageManager.ErrorPackageFolder) {

                textPackageMangerErrorInfo.text = qsTr("Unable to create package folder")

            } else if(packageManager.error == PackageManager.ErrorDownloading) {

                textPackageMangerErrorInfo.text = qsTr("Unable to download package file")

            } else if(packageManager.error == PackageManager.ErrorInvalidPackageInfo) {

                textPackageMangerErrorInfo.text = qsTr("Unable to parse package information")

            } else if(packageManager.error == PackageManager.ErrorCopy) {

                textPackageMangerErrorInfo.text = qsTr("Unable to copy package files")

            } else if(packageManager.error == PackageManager.ErrorBadId) {

                textPackageMangerErrorInfo.text = qsTr("Invalid package id")

            }


        }
    }

    //
    // Set initial window size
    //
    onVisibleChanged: {

        if(visible) {


            var orgWidth = Screen.devicePixelRatio == 2 ? 1920 / 1.5 : 1920 * 0.90

            if(Screen.desktopAvailableWidth < orgWidth)
                orgWidth = Screen.desktopAvailableWidth

            var orgHeight =  Screen.devicePixelRatio == 2 ? 1080 / 1.5 : 1080 * 0.90

            if(Screen.desktopAvailableHeight < orgHeight)
                orgHeight = Screen.desktopAvailableHeight

            height = orgHeight
            width = orgWidth


            packageManager.packageId = "462144DC-DB05-455E-B726-3C91ED429D4F" // Once pubic never change this. Also unique for every package

            //
            // Read settings only after packageId set
            //
            useDevPackage = packageManager.getSettingValue("common/developerMode",false)

            //
            // Now we have final source so start initialize packageManager
            //
            packageManager.source = packageSource

            packageManager.initialize()

        }


    }

    function fourceUpdate(isUpdate)
    {
        mainRootLoader.source = ""
        mainRootWindow.isUpdate = isUpdate
        packageManager.forceDownload()
    }

}

