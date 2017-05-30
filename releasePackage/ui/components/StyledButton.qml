import QtQuick 2.7


Item  {


    id: button
    width: (!button.useFontAwesome ? textNormal.paintedWidth : textFontAwesome.paintedWidth) + (20 )
    height: 40
    opacity: !mouseArea.containsPress ? 1 : 0.75

    property string text: "Button"
    property bool useFontAwesome: false
    property color textColor: "white"
    property color textHoverColor: "black"
    property color buttonColor: "blue"
    signal clicked()


    readonly property real radius: 4

    Canvas {
        id:canvas1
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            ctx.beginPath();
            ctx.lineWidth = height * 0.1
            ctx.roundedRect(ctx.lineWidth / 2, ctx.lineWidth / 2,
                            width - ctx.lineWidth, height - ctx.lineWidth, button.radius, button.radius);
            ctx.strokeStyle = "grey";
            ctx.stroke();
            ctx.fillStyle = button.buttonColor;
            ctx.fill();
        }
    }

    TextWhiteMedium {
        id: textNormal
        text: button.text
        color: mouseArea.containsMouse ? button.textHoverColor : button.textColor
        anchors.centerIn: parent
        visible: !button.useFontAwesome


    }

    TextWhiteMedium {
        id: textFontAwesome
        text: button.text
        color: mouseArea.containsMouse ? button.textHoverColor : button.textColor
        font.family: "FontAwesome"
        anchors.centerIn: parent
        visible: button.useFontAwesome

    }

    Canvas {
        id:canvas2
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            ctx.beginPath();
            ctx.lineWidth = height * 0.1
            ctx.roundedRect(ctx.lineWidth / 2, ctx.lineWidth / 2,
                            width - ctx.lineWidth, height - ctx.lineWidth, button.radius, button.radius);
            ctx.moveTo(0, height * 0.4);
            ctx.bezierCurveTo(width * 0.25, height * 0.6, width * 0.75, height * 0.6, width, height * 0.4);
            ctx.lineTo(width, height);
            ctx.lineTo(0, height);
            ctx.lineTo(0, height * 0.4);
            ctx.clip();

            ctx.beginPath();
            ctx.roundedRect(ctx.lineWidth / 2, ctx.lineWidth / 2,
                            width - ctx.lineWidth, height - ctx.lineWidth,
                            button.radius, button.radius);
            var gradient = ctx.createLinearGradient(0, 0, 0, height);
            gradient.addColorStop(0, "#bbffffff");
            gradient.addColorStop(0.6, "#00ffffff");
            ctx.fillStyle = gradient;
            ctx.fill();
        }
    }

    MouseArea {
        id:mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            button.clicked()
        }
    }

    Component.onCompleted: {

        canvas1.requestPaint()
        canvas2.requestPaint()
    }

}



