TEMPLATE = app

QT += qml quick
CONFIG += c++11

SOURCES += main.cpp


LIBS += user32.lib

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    ProfileSettings.qml \
    devPackage/packageInfo.json\
    devPackage/ui/Launch.qml \
    devPackage/ui/components/TextBase.qml \
    devPackage/ui/components/TextBlueBigTitle.qml \
    devPackage/ui/components/CheckUpdate.qml \
    devPackage/ui/components/TextBlueMedium.qml \
    devPackage/ui/components/TextBlueSmall.qml \
    devPackage/ui/components/TextWhiteBigTitle.qml \
    devPackage/ui/components/TextWhiteMedium.qml \
    devPackage/ui/components/TextWhiteSmall.qml \
    devPackage/ui/components/TextBlackBigTitle.qml \
    devPackage/ui/components/TextBlackMedium.qml \
    devPackage/ui/components/TextBlackSmall.qml \
    devPackage/ui/components/TextRedBigTitle.qml \
    devPackage/ui/components/TextWarning.qml \
    devPackage/ui/components/StyledBusyIndicator.qml \
    devPackage/ui/components/FontAwesome.qml \
    devPackage/ui/components/FontAwesomeVariables.qml \
    devPackage/ui/components/StyledButton.qml \
    devPackage/ui/components/StackViewBase.qml \
    devPackage/ui/components/PaperRipple.qml \
    devPackage/ui/components/PaperShadow.qml \
    devPackage/ui/components/RaisedButton.qml \
    devPackage/ui/components/RaisedButtonGreen.qml \
    devPackage/ui/components/RaisedButtonRed.qml \
    devPackage/ui/components/StyledCheckBox.qml \
    devPackage/ui/pages/PageBase.qml \
    devPackage/ui/pages/PageGenericError.qml \
    devPackage/ui/pages/PageWelcome.qml \
    devPackage/ui/pages/PageProfileCreationChoice.qml \
    devPackage/ui/scripts/Utility.js \
    devPackage/ui/scripts/Settings.js \
    devPackage/ui/scripts/DeviceInfo.js \
    devPackage/ui/components/StyledRadioButton.qml \
    devPackage/ui/scripts/WizardState.js \
    devPackage/ui/components/PopupGeneric.qml \
    devPackage/ui/components/PopupContent.qml \
    devPackage/ui/popups/PopupSettings.qml







