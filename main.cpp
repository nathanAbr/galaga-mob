#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //qputenv("QSG_VISUALIZE", "overdraw");
    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/PageLoader.qml")), "Qt.loader.qLoaderPageSingleton", 1, 0, "LoaderPage");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
