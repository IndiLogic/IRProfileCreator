.pragma library

var _packageManager = null;

function initialize(packageManager) {

    _packageManager = packageManager
}

function value(key,defaultValue) {

    if(_packageManager)
        return _packageManager.getSettingValue(key,defaultValue);
    else
        return defaultValue

}

function setValue(key,value) {

    if(_packageManager)
        return _packageManager.setSettingValue(key,value);
    else
        return false;

}

function showWelcomePage() {

    return value("common/showWelcomePage",true)
}

function setShowWelcomePage(show) {

    return setValue("common/showWelcomePage",show)
}

function developerMode() {

    return value("common/developerMode",false)
}

function setDeveloperMode(enable) {

    return setValue("common/developerMode",enable)
}
