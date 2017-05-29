#include <qt_windows.h>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute ( Qt::AA_UseHighDpiPixmaps );

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    //
    // Change launch qml path as your folder
    //
    engine.load(QUrl(QStringLiteral("file:///C:/temp/IRProfileCreator/devPackage/ui/Launch.qml")));


    return app.exec();
}
