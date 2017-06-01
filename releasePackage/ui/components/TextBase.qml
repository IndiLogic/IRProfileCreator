import QtQuick 2.7

Text {
    id: textMain
    font.family: "Segoe UI"
    renderType: Text.QtRendering
    z:1

    property alias shadowColor : textShadow.color
    property alias shadowEnable: textShadow.visible

    Text{

        id: textShadow
        z:-1
        anchors.fill: parent
        anchors.topMargin: 1 
        anchors.leftMargin: 1 
        anchors.rightMargin: -1 
        anchors.bottomMargin: -1 
        text: textMain.text
        font.bold: textMain.font.bold
        font.pixelSize: textMain.font.pixelSize
        color: "black"
        font.family: textMain.font.family
        font.weight: textMain.font.weight
        wrapMode : textMain.wrapMode
        renderType: textMain.renderType
        horizontalAlignment : textMain.horizontalAlignment
        verticalAlignment: textMain.verticalAlignment
        textFormat: textMain.textFormat
        elide : textMain.elide
        fontSizeMode : textMain.fontSizeMode
    }
}
