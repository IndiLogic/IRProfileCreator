import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2


Rectangle {
    id: rectangleRoot
    parent: mainRootLoader
    anchors.fill: parent

    z: 1000
    color: "#800c0c0c"
    visible: opacity > 0.0
    opacity: 0.0

    property Item contentItem: null
    property alias titleText: textTitle.text
    readonly property Item closeButton: buttonClose

    FontAwesome {
        id: fontAwesome
    }

    Keys.onEscapePressed: {
        close()
        event.accepted = true
    }

    MouseArea {
        anchors.fill: parent
        enabled:  parent.visible
        visible: parent.visible
        hoverEnabled: true

    }

    Rectangle{
        id: rectangleBackGround
        height: rectangleContent.width
        width: rectangleContent.height
        radius: rectangleContent.radius

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

    Rectangle {
        id: rectangleContent
        height: contentItem ? (contentItem.height + (border.width  * 2)) +  itemTitleBar.height : 0
        width: contentItem ? contentItem.width + (border.width  * 2) : 0
        anchors.centerIn: parent

        property Item lastFocuItem: null

        color: "transparent"
        radius: 6
        border.width: 3
        border.color: "white"

        Item {
            id: itemTitleBar
            width : parent.width
            height: 56

            TextBlueBigTitle {
                id: textTitle
                text: "This is going to"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            RaisedButtonRed {
                id: buttonClose
                useFontAwesome:true
                text:fontAwesome.icons.fa_times
                anchors.verticalCenter:  parent.verticalCenter
                anchors.verticalCenterOffset: 3
                anchors.right: parent.right
                anchors.rightMargin: 10
                onClicked: close()
            }

            Rectangle {
                id: rectangleLine
                width: parent.width - (rectangleContent.border.width * 2)
                height: 2
                color: "gray"
                anchors.top: textTitle.bottom
                anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }



        Item {
            id:itemContentParent
            height: contentItem ? contentItem.width : 0
            width: contentItem ? contentItem.height : 0
            x : rectangleContent.border.width
            y : itemTitleBar.height + rectangleContent.border.width

        }


    }

    onContentItemChanged: {
        contentItem.parent = itemContentParent

    }

    onVisibleChanged: {

        if(!visible && rectangleContent.lastFocuItem)
        {
            rectangleContent.lastFocuItem.forceActiveFocus(Qt.TabFocusReason)
            rectangleContent.lastFocuItem = null
        }
    }

    function open()
    {
        rectangleContent.lastFocuItem = Window.activeFocusItem
        opacity = 1.0
    }

    function close()
    {
        opacity = 0.0
    }



    Behavior on opacity {
        SmoothedAnimation { velocity: 0.1; duration: 200 }
    }


}


