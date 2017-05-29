import QtQuick 2.7
import "../components"

PageBase {


    isNextAllow: false
    property string errorString: ""

    TextRedBigTitle{
        text: errorString
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    function processNext()
    {
    }


}
