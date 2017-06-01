import QtQuick 2.7
import "../components"

Item {

    width : 1890
    height : 954

    property bool isNextAllow: true // enable or disable next button
    property bool isBackAllow: true // enable or disable back button
    property bool isCancleAllow: true // enable or disable close/cancle button
    property string nextText: qsTr("Next")
    property alias displayHeader: columnHeaderContent.visible
    property alias headerText: textTitle.text
    readonly property Item pageContentParent : rectanglePageContent

    /*Rectangle {
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

    FontAwesome {
        id: fontAwesome
    }

    Column {
        id:columnHeaderContent
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 15
        spacing: 5
        visible: false

        TextBlueBigTitle {
            id:textTitle
            text: "Header Text"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }

        Row
        {
            id: rowHelpContent
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 11

            TextWhiteSmall {
                text: qsTr("Click on")
            }

            TextWhiteSmall {
                font.family: "FontAwesome"
                text: fontAwesome.icons.fa_question_circle
                anchors.verticalCenter: parent.verticalCenter
            }

            TextWhiteSmall {
                text: qsTr("icon next to options for more help")
            }
        }
    }

    Rectangle
    {
        id:rectanglePageContent
        color: "#15e4e4e4"
        anchors.margins: 5
        anchors.top: columnHeaderContent.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        radius: 8
    }
}
