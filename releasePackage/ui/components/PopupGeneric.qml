import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtQuick.Controls 2.0

Rectangle {
    id: rectangleRoot
    parent: mainRootLoader
    anchors.fill: parent

    z: 2000
    color: "#800c0c0c"
    visible: opacity > 0.0
    opacity: 0.0
    focus: opacity > 0.0

    property alias text: mainText.text

    Keys.onEscapePressed: {
        close()
        event.accepted = true
    }

    MouseArea {
        anchors.fill: parent
        enabled:  parent.visible
        visible: parent.visible
        hoverEnabled: true

        onClicked: {

            var globalCoordinares = rectangleRoot.mapToItem(rectangleContent, mouse.x, mouse.y)

            if(globalCoordinares.x < 0  || globalCoordinares.x > rectangleContent.width) {
                close()
                return
            }

            if(globalCoordinares.y < 0 ||  globalCoordinares.y > rectangleContent.height) {
                close()
                return
            }
        }

    }

    Rectangle {
        id: rectangleContent
        height: columnRoot.height + 40
        width: columnRoot.width + 40
        anchors.centerIn: parent
        property Item lastFocuItem: null

        color: "white"
        radius: 18
        border.width: 4
        border.color: "orange"

        activeFocusOnTab: true
        KeyNavigation.tab: rectangleContent
        KeyNavigation.backtab: rectangleContent

        Column {
            id: columnRoot
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Flickable {
                id:flickable
                focus: true
                clip: true
                width : mainText.width
                height: mainText.height

                contentHeight: mainText.paintedHeight

                ColumnLayout {
                    spacing: 0

                    TextBlackMedium {
                        id: mainText
                        shadowEnable: false
                        wrapMode: Text.WordWrap
                        Layout.maximumWidth: 900
                        Layout.maximumHeight: 600

                    }
                }

                ScrollBar.vertical: ScrollBar {
                    id: vbar
                    active: true
                }


            }

        }
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
        if(mainText.text.length > 0)
        {

            /*var globalCoordinares = mapToItem(Window.contentItem, 0, 0)

                x = x - globalCoordinares.x
                y = y - globalCoordinares.y*/

            flickable.contentY = 0

            vbar.active = false
            vbar.active = true

            rectangleContent.lastFocuItem = Window.activeFocusItem
            opacity = 1.0
        }
    }

    function close()
    {
        opacity = 0.0

    }

    Behavior on opacity {
        SmoothedAnimation { velocity: 0.1; duration: 200 }
    }


}


