.pragma library

var _selectedDeviceCollection = null;

var deviceInfo = {
    isSupported: false,
    id: -1,
    dirBase: null,
    name: null
};

function initialize(selectedDeviceCollection) {

    _selectedDeviceCollection = selectedDeviceCollection;

    if(selectedDeviceCollection.id === "A8DB0993-5337-47D7-8D17-D1E8C3F3AF6F") {

        //
        // This is a Steam controller
        //
        deviceInfo.isSupported = true;
        deviceInfo.id = 0;
        deviceInfo.dirBase = "steam"; // do not translate
        deviceInfo.name = qsTr("Steam controller"); // this must translate

    } else if(selectedDeviceCollection.id === "F842B2B7-9A66-446E-841A-4AADA10BC034") {

        //
        // This is a DS4 controller
        //
        deviceInfo.isSupported = true;
        deviceInfo.id = 1;
        deviceInfo.dirBase = "ds4"; // do not translate
        deviceInfo.name = qsTr("DS4 controller"); // this must translate

    }else if(selectedDeviceCollection.id === "E48BAB84-060F-4E26-B440-A49324C89E75") {

        //
        // This is a all XInput controllers
        //
        deviceInfo.isSupported = true;
        deviceInfo.id = 2;
        deviceInfo.dirBase = "xinput"; // do not translate
        deviceInfo.name = qsTr("XInput controller"); // this must translate

    }

}
