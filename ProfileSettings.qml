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
    title: getString(qsTr("InputRediraction Profile Creator"))

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

                    text: getString(qsTr("Welcome To InputRedirection Profile Creator")) + (packageManager.state == PackageManager.StateReady ? " (" + packageManager.version + ")" : "")
                    Layout.fillHeight: false
                    font.family: "Segoe UI"
                    color: "#ff02BEE2"
                    font.pixelSize: 50
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillWidth: true
                }

                Text {
                    id:textPackageMangerState
                    text: getString(qsTr("Initializing package. Please wait..."))
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
                text: getString(qsTr("To proceed, you must have to download package."))
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Segoe UI"
                color: "yellow"
                font.pixelSize: 40
                visible: packageManager.state == PackageManager.StatePackageDownloadRequired

            }

            Button {
                id: buttonDownload
                text: getString(qsTr("Start Download"))
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
                text: getString(qsTr("Downloading")) + " : " + packageManager.downloadingSource
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
                    text: getString(qsTr("Download Progress")) + " : "
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
                text: getString(qsTr("Downloading Failed")) + " : " + packageManager.downloadingSource
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
                text: getString(qsTr("Error Code")) + " : " + packageManager.errorCode
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
                text: getString(qsTr("Error")) + " : " + packageManager.errorString
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
                text: !isUpdate ? getString(qsTr("Try Again")) : getString(qsTr("Launch Old Interface"))
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
                text: getString(qsTr("Error Code")) + " : " + packageManager.errorCode
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
                text: getString(qsTr("Error")) + " : " + packageManager.errorString
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
                    text: getString(qsTr("File Copy Progress")) + " : "
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
                text: getString(qsTr("Unable to load the main interface"))
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Segoe UI"
                color: "red"
                font.pixelSize: 40
                visible: mainRootLoader.status == Loader.Error

            }

            Text {
                id:textLoaderErrorInfo
                text: getString(qsTr("Try force downloading again"))
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
                text: getString(qsTr("Force Download Again"))
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

                textPackageMangerState.text = getString(qsTr("Error occurred during initialization of package"))

            } else if(packageManager.state == PackageManager.StateInitializing) {

                textPackageMangerState.text = getString(qsTr("Initializing package. Please wait..."))

            } else if(packageManager.state == PackageManager.StatePackageDownloadRequired) {

                if(isUpdate) {
                    textPackageMangerState.text = getString(qsTr("Package download required for update"))
                    textPackageMangerDownloadRequired.text = getString(qsTr("Update to latest version, you must have to download new package"))
                }
                else
                    textPackageMangerState.text = getString(qsTr("Package download required"))


            } else if(packageManager.state == PackageManager.StateDownloading) {

                textPackageMangerState.text = getString(qsTr("Downloading package files. Please wait..."))

            } else if(packageManager.state == PackageManager.StateCopyfile) {

                textPackageMangerState.text = getString(qsTr("Copying package files. Please wait..."))

            } else if(packageManager.state == PackageManager.StateReady) {

                textPackageMangerState.text = getString(qsTr('Launching interface. Please wait...'))
                mainRootLoader.source = "file:///" + packageManager.packageDir + "/ui/Launch.qml" // lauch from downloaded package

            }

        }
        onErrorChanged: {

            if(packageManager.error == PackageManager.ErrorPackageSource) {

                textPackageMangerErrorInfo.text = getString(qsTr("Package source is not valid"))

            } else if(packageManager.error == PackageManager.ErrorPackageFolder) {

                textPackageMangerErrorInfo.text = getString(qsTr("Unable to create package folder"))

            } else if(packageManager.error == PackageManager.ErrorDownloading) {

                textPackageMangerErrorInfo.text = getString(qsTr("Unable to download package file"))

            } else if(packageManager.error == PackageManager.ErrorInvalidPackageInfo) {

                textPackageMangerErrorInfo.text = getString(qsTr("Unable to parse package information"))

            } else if(packageManager.error == PackageManager.ErrorCopy) {

                textPackageMangerErrorInfo.text = getString(qsTr("Unable to copy package files"))

            } else if(packageManager.error == PackageManager.ErrorBadId) {

                textPackageMangerErrorInfo.text = getString(qsTr("Invalid package id"))

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
        packageManager.source = packageSource
        packageManager.forceDownload()
    }


    function getString(srcString)
    {
        var retString = srcString

        var lang = null
        if(mainRootWindow.thisPageStrings.hasOwnProperty(Qt.locale().name))
            lang = Qt.locale().name
        else if(mainRootWindow.thisPageStrings.hasOwnProperty(Qt.locale().name.substring(0,2)))
            lang = Qt.locale().name.substring(0,2)


        if(lang)
        {

            for(var index in mainRootWindow.thisPageStrings[lang])
            {

                if(mainRootWindow.thisPageStrings[lang][index].src === srcString)
                {
                    retString = mainRootWindow.thisPageStrings[lang][index].dest
                }
            }

        }

        return retString;
    }

    property var thisPageStrings: {

        "de" : [
                    {
                        "src" : "InputRediraction Profile Creator",
                        "dest" : "InputRediraction Profile Creator",
                    },
                    {
                        "src" : "Welcome To InputRedirection Profile Creator",
                        "dest" : "Willkommen bei InputRedirection Profile Creator",
                    },
                    {
                        "src" : "Initializing package. Please wait...",
                        "dest" : "Initialisierungspaket. Warten Sie mal...",
                    },
                    {
                        "src" : "To proceed, you must have to download package.",
                        "dest" : "Um fortzufahren, musst du das Paket herunterladen.",
                    },
                    {
                        "src" : "Start Download",
                        "dest" : "Starte Download",
                    },
                    {
                        "src" : "Downloading",
                        "dest" : "wird heruntergeladen",
                    },
                    {
                        "src" : "Download Progress",
                        "dest" : "Herunterladen Progress",
                    },
                    {
                        "src" : "Downloading Failed",
                        "dest" : "Herunterladen fehlgeschlagen",
                    },
                    {
                        "src" : "Error Code",
                        "dest" : "Fehlercode",
                    },
                    {
                        "src" : "Error",
                        "dest" : "Fehler",
                    },
                    {
                        "src" : "Try Again",
                        "dest" : "Versuch es noch einmal",
                    },
                    {
                        "src" : "Launch Old Interface",
                        "dest" : "Starten Sie alte Schnittstelle",
                    },
                    {
                        "src" : "File Copy Progress",
                        "dest" : "Datei Kopiervorgang",
                    },
                    {
                        "src" : "Unable to load the main interface",
                        "dest" : "Die Hauptschnittstelle kann nicht geladen werden",
                    },
                    {
                        "src" : "Try force downloading again",
                        "dest" : "Versuche Kraft, wieder herunterzuladen",
                    },
                    {
                        "src" : "Force Download Again",
                        "dest" : "Force Download Wieder",
                    },
                    {
                        "src" : "Error occurred during initialization of package",
                        "dest" : "Bei der Initialisierung des Pakets ist ein Fehler aufgetreten",
                    },
                    {
                        "src" : "Package download required for update",
                        "dest" : "Paket-Download für Update erforderlich",
                    },
                    {
                        "src" : "Update to latest version, you must have to download new package",
                        "dest" : "Aktualisieren Sie auf die neueste Version, müssen Sie das neue Paket herunterladen müssen",
                    },
                    {
                        "src" : "Package download required",
                        "dest" : "Paket-Download erforderlich",
                    },
                    {
                        "src" : "Downloading package files. Please wait...",
                        "dest" : "Herunterladen von Paketdateien. Warten Sie mal...",
                    },
                    {
                        "src" : "Copying package files. Please wait...",
                        "dest" : "Kopieren von Paketdateien. Warten Sie mal...",
                    },
                    {
                        "src" : "Launching interface. Please wait...",
                        "dest" : "Startoberfläche Warten Sie mal...",
                    },
                    {
                        "src" : "Package source is not valid",
                        "dest" : "Paketquelle ist nicht gültig",
                    },
                    {
                        "src" : "Unable to create package folder",
                        "dest" : "Der Paketordner kann nicht erstellt werden",
                    },
                    {
                        "src" : "Unable to download package file",
                        "dest" : "Paketdatei kann nicht heruntergeladen werden",
                    },
                    {
                        "src" : "Unable to parse package information",
                        "dest" : "Die Paketinformationen können nicht parsen",
                    },
                    {
                        "src" : "Unable to copy package files",
                        "dest" : "Paketdateien können nicht kopiert werden",
                    },
                    {
                        "src" : "Invalid package id",
                        "dest" : "Ungültige Paket-ID",
                    }


        ],
        "es" : [
                    {
                        "src" : "InputRediraction Profile Creator",
                        "dest" : "Creador de perfiles de InputRediraction",
                    },
                    {
                        "src" : "Welcome To InputRedirection Profile Creator",
                        "dest" : "Bienvenido a InputRedirection Profile Creator",
                    },
                    {
                        "src" : "Initializing package. Please wait...",
                        "dest" : "Inicializando el paquete. Por favor espera...",
                    },
                    {
                        "src" : "To proceed, you must have to download package.",
                        "dest" : "Para continuar, debe tener que descargar el paquete.",
                    },
                    {
                        "src" : "Start Download",
                        "dest" : "Comienza a descargar",
                    },
                    {
                        "src" : "Downloading",
                        "dest" : "Descargando",
                    },
                    {
                        "src" : "Download Progress",
                        "dest" : "Progreso de la descarga",
                    },
                    {
                        "src" : "Downloading Failed",
                        "dest" : "Error al cargar",
                    },
                    {
                        "src" : "Error Code",
                        "dest" : "Código de error",
                    },
                    {
                        "src" : "Error",
                        "dest" : "Error",
                    },
                    {
                        "src" : "Try Again",
                        "dest" : "Inténtalo de nuevo",
                    },
                    {
                        "src" : "Launch Old Interface",
                        "dest" : "Iniciar interfaz antiguo",
                    },
                    {
                        "src" : "File Copy Progress",
                        "dest" : "Progreso de la copia de archivo",
                    },
                    {
                        "src" : "Unable to load the main interface",
                        "dest" : "No se puede cargar la interfaz principal",
                    },
                    {
                        "src" : "Try force downloading again",
                        "dest" : "Intente descargar la fuerza de nuevo",
                    },
                    {
                        "src" : "Force Download Again",
                        "dest" : "Force Descargar de nuevo",
                    },
                    {
                        "src" : "Error occurred during initialization of package",
                        "dest" : "Se ha producido un error durante la inicialización del paquete",
                    },
                    {
                        "src" : "Package download required for update",
                        "dest" : "Se requiere la descarga del paquete para actualizar",
                    },
                    {
                        "src" : "Update to latest version, you must have to download new package",
                        "dest" : "Actualizar a la última versión, debe tener para descargar nuevo paquete",
                    },
                    {
                        "src" : "Package download required",
                        "dest" : "Se necesita descargar el paquete",
                    },
                    {
                        "src" : "Downloading package files. Please wait...",
                        "dest" : "Descargando los archivos del paquete. Por favor espera...",
                    },
                    {
                        "src" : "Copying package files. Please wait...",
                        "dest" : "Copia de archivos de paquetes. Por favor espera...",
                    },
                    {
                        "src" : "Launching interface. Please wait...",
                        "dest" : "Interfaz de lanzamiento. Por favor espera...",
                    },
                    {
                        "src" : "Package source is not valid",
                        "dest" : "La fuente del paquete no es válida",
                    },
                    {
                        "src" : "Unable to create package folder",
                        "dest" : "No se puede crear la carpeta del paquete",
                    },
                    {
                        "src" : "Unable to download package file",
                        "dest" : "No se puede descargar el archivo de paquete",
                    },
                    {
                        "src" : "Unable to parse package information",
                        "dest" : "No se puede analizar la información del paquete",
                    },
                    {
                        "src" : "Unable to copy package files",
                        "dest" : "No se pueden copiar los archivos del paquete",
                    },
                    {
                        "src" : "Invalid package id",
                        "dest" : "ID de paquete no válido",
                    }
        ],
        "ja" : [
                    {
                        "src" : "InputRediraction Profile Creator",
                        "dest" : "InputRediractionプロファイル作成者",
                    },
                    {
                        "src" : "Welcome To InputRedirection Profile Creator",
                        "dest" : "パッケージの初期化。お待ちください...",
                    },
                    {
                        "src" : "Initializing package. Please wait...",
                        "dest" : "パッケージを初期化しています。お待ちください...",
                    },
                    {
                        "src" : "To proceed, you must have to download package.",
                        "dest" : "続行するには、パッケージをダウンロードする必要があります。",
                    },
                    {
                        "src" : "Start Download",
                        "dest" : "ダウンロードを開始する",
                    },
                    {
                        "src" : "Downloading",
                        "dest" : "ダウンロード",
                    },
                    {
                        "src" : "Download Progress",
                        "dest" : "進行状況をダウンロード",
                    },
                    {
                        "src" : "Downloading Failed",
                        "dest" : "ダウンロードに失敗しました",
                    },
                    {
                        "src" : "Error Code",
                        "dest" : "エラーコード",
                    },
                    {
                        "src" : "Error",
                        "dest" : "エラー",
                    },
                    {
                        "src" : "Try Again",
                        "dest" : "再試行する",
                    },
                    {
                        "src" : "Launch Old Interface",
                        "dest" : "古いインタフェースを起動する",
                    },
                    {
                        "src" : "File Copy Progress",
                        "dest" : "ファイルコピーの進行状況",
                    },
                    {
                        "src" : "Unable to load the main interface",
                        "dest" : "メインインターフェイスを読み込めません",
                    },
                    {
                        "src" : "Try force downloading again",
                        "dest" : "再度強制的にダウンロードしてみてください",
                    },
                    {
                        "src" : "Force Download Again",
                        "dest" : "もう一度ダウンロードを強制する",
                    },
                    {
                        "src" : "Error occurred during initialization of package",
                        "dest" : "パッケージの初期化中にエラーが発生しました",
                    },
                    {
                        "src" : "Package download required for update",
                        "dest" : "アップデートにはパッケージのダウンロードが必要です",
                    },
                    {
                        "src" : "Update to latest version, you must have to download new package",
                        "dest" : "最新バージョンに更新するには、新しいパッケージをダウンロードする必要があります",
                    },
                    {
                        "src" : "Package download required",
                        "dest" : "パッケージのダウンロードが必要です",
                    },
                    {
                        "src" : "Downloading package files. Please wait...",
                        "dest" : "パッケージファイルをダウンロードしています。 お待ちください...",
                    },
                    {
                        "src" : "Copying package files. Please wait...",
                        "dest" : "パッケージファイルのコピー。 お待ちください...",
                    },
                    {
                        "src" : "Launching interface. Please wait...",
                        "dest" : "起動インタフェース。 お待ちください...",
                    },
                    {
                        "src" : "Package source is not valid",
                        "dest" : "パッケージソースが無効です",
                    },
                    {
                        "src" : "Unable to create package folder",
                        "dest" : "パッケージフォルダを作成できません",
                    },
                    {
                        "src" : "Unable to download package file",
                        "dest" : "パッケージファイルをダウンロードできません",
                    },
                    {
                        "src" : "Unable to parse package information",
                        "dest" : "パッケージ情報を解析できません",
                    },
                    {
                        "src" : "Unable to copy package files",
                        "dest" : "パッケージファイルをコピーできません",
                    },
                    {
                        "src" : "Invalid package id",
                        "dest" : "パッケージIDが無効です",
                    }
        ],
        "ru" : [
                    {
                        "src" : "InputRediraction Profile Creator",
                        "dest" : "Создатель профиля InputRediraction",
                    },
                    {
                        "src" : "Welcome To InputRedirection Profile Creator",
                        "dest" : "Добро пожаловать в конструктор профиля InputRedirection",
                    },
                    {
                        "src" : "Initializing package. Please wait...",
                        "dest" : "Инициализация пакета. Пожалуйста, подождите...",
                    },
                    {
                        "src" : "To proceed, you must have to download package.",
                        "dest" : "Чтобы продолжить, вам необходимо загрузить пакет.",
                    },
                    {
                        "src" : "Start Download",
                        "dest" : "Начать загрузку",
                    },
                    {
                        "src" : "Downloading",
                        "dest" : "загрузка",
                    },
                    {
                        "src" : "Download Progress",
                        "dest" : "Скачать Прогресс",
                    },
                    {
                        "src" : "Downloading Failed",
                        "dest" : "Ошибка загрузки",
                    },
                    {
                        "src" : "Error Code",
                        "dest" : "Код ошибки",
                    },
                    {
                        "src" : "Error",
                        "dest" : "ошибка",
                    },
                    {
                        "src" : "Try Again",
                        "dest" : "Попробуй еще раз",
                    },
                    {
                        "src" : "Launch Old Interface",
                        "dest" : "Запуск старого интерфейса",
                    },
                    {
                        "src" : "File Copy Progress",
                        "dest" : "Прогресс копирования файлов",
                    },
                    {
                        "src" : "Unable to load the main interface",
                        "dest" : "Не удалось загрузить основной интерфейс",
                    },
                    {
                        "src" : "Try force downloading again",
                        "dest" : "Повторите попытку загрузки",
                    },
                    {
                        "src" : "Force Download Again",
                        "dest" : "Сила загрузки снова",
                    },
                    {
                        "src" : "Error occurred during initialization of package",
                        "dest" : "Ошибка при инициализации пакета",
                    },
                    {
                        "src" : "Package download required for update",
                        "dest" : "Загрузка пакета требуется для обновления",
                    },
                    {
                        "src" : "Update to latest version, you must have to download new package",
                        "dest" : "Обновление до последней версии, вам необходимо загрузить новый пакет",
                    },
                    {
                        "src" : "Package download required",
                        "dest" : "Требуется загрузка пакета",
                    },
                    {
                        "src" : "Downloading package files. Please wait...",
                        "dest" : "Загрузка файлов пакетов. Пожалуйста, подождите...",
                    },
                    {
                        "src" : "Copying package files. Please wait...",
                        "dest" : "Копирование файлов пакетов. Пожалуйста, подождите...",
                    },
                    {
                        "src" : "Launching interface. Please wait...",
                        "dest" : "Запуск интерфейса. Пожалуйста, подождите...",
                    },
                    {
                        "src" : "Package source is not valid",
                        "dest" : "Исходный код источника недействителен",
                    },
                    {
                        "src" : "Unable to create package folder",
                        "dest" : "Не удалось создать папку пакета",
                    },
                    {
                        "src" : "Unable to download package file",
                        "dest" : "Не удалось загрузить файл пакета",
                    },
                    {
                        "src" : "Unable to parse package information",
                        "dest" : "Невозможно разобрать информацию о пакете",
                    },
                    {
                        "src" : "Unable to copy package files",
                        "dest" : "Не удалось скопировать файлы пакетов",
                    },
                    {
                        "src" : "Invalid package id",
                        "dest" : "Недопустимый идентификатор пакета",
                    }
        ]
    }

}

