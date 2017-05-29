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

    }

}
