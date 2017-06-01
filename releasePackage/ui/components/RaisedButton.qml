import QtQuick 2.7
import QtQuick.Controls 2.0

Button {
    id: button
    width: (!button.useFontAwesome ? textNormal.paintedWidth : textFontAwesome.paintedWidth) + (20 ) + widthPadding
    height: 40

    property color buttonColor: "green"
    property color textHoverColor: "gray"
    property color textColor: "white"
    property color textShadowColor: "black"
    property bool  textShadowEnable: true
    property alias rippleColor: ripple.color
    property bool useFontAwesome: false
    property int widthPadding: 0
    property color activeBorderColor: "orange"


    background : Item{}
    contentItem: Item{}


    Rectangle {
        id: background
        anchors.fill: parent
        radius: 4
        color: button.enabled ? button.buttonColor : "#eaeaea"
        visible: true
        border.color: button.activeFocus ? activeBorderColor : "#00000000"
        border.width: 3
    }

    PaperShadow {
        id: shadow
        source: background
        depth: button.enabled ? (mouseArea.pressed ? (3 ) : (1 ) ) : 0
    }


    TextWhiteMedium {
        id: textNormal
        anchors.centerIn: parent
        color: mouseArea.containsMouse && !mouseArea.pressed ? button.textHoverColor : button.textColor
        opacity: button.enabled ? 1 : 0.62
        text:button.text
        shadowColor: button.textShadowColor
        shadowEnable: button.textShadowEnable
        visible: !button.useFontAwesome
        font.weight: Font.DemiBold

        Behavior on opacity {
            NumberAnimation {
                duration: 200
                easing.type: Easing.Bezier;
                easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
            }
        }
    }

    TextWhiteMedium {
        id: textFontAwesome
        anchors.centerIn: parent
        color: mouseArea.containsMouse && !mouseArea.pressed ? button.textHoverColor : button.textColor
        font.family: "FontAwesome"
        opacity: button.enabled ? 1 : 0.62
        text:button.text
        shadowColor: button.textShadowColor
        shadowEnable: button.textShadowEnable
        visible: button.useFontAwesome
        font.weight: Font.DemiBold

        Behavior on opacity {
            NumberAnimation {
                duration: 200
                easing.type: Easing.Bezier;
                easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
            }
        }
    }
    PaperRipple {
        id: ripple
        radius: 3
        mouseArea: mouseArea
        color: "#deffffff"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        enabled: button.enabled
        onClicked: button.clicked()
    }
}
