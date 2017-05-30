import QtQuick 2.7

Item {


    id: control
    width: row.width
    height: row.height

    property alias text: text.text
    property color color: "orange"

    FontAwesome {
        id: fontAwesome
    }
    Row {
        id: row
        spacing: 22

        TextWhiteBigTitle {
            color: control.color
            font.family: "FontAwesome"
            text: fontAwesome.icons.fa_warning
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignTop
        }

        TextWhiteMedium {
            id:text
            color: control.color
            text: "TextWarning"
        }
    }
}
