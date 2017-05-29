import QtQuick 2.7

Item {
    id: fontAwesome

    property alias icons: variables

    readonly property string family: "FontAwesome"

    FontAwesomeVariables {
        id: variables
    }
}
