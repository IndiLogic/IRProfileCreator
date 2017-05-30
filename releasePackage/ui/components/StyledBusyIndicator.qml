import QtQuick 2.7

Item {
    id:control

    property alias color: icon.color

    FontAwesome {
        id: fontAwesome
    }

    Text {
        id: icon
        anchors.fill: parent
        font.pixelSize: 400 
        fontSizeMode: Text.Fit
        font.family: fontAwesome.family
        text: fontAwesome.icons.fa_refresh
        horizontalAlignment: Text.AlignHCenter
        minimumPixelSize: 1
        renderType: Text.QtRendering

        NumberAnimation on rotation {
            from: 0
            to: 360
            running: control.visible
            loops: Animation.Infinite
            duration: 1200
        }

    }
}
