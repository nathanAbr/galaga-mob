#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //qputenv("QSG_VISUALIZE", "overdraw");
    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/PageLoader.qml")), "Qt.loader.qLoaderPageSingleton", 1, 0, "LoaderPage");
    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/SoundManager.qml")), "Qt.SoundManager.qSoundManagerSingleton", 1, 0, "Sounds");
    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/Score.qml")), "Qt.score.qScoreSingleton", 1, 0, "Score");
    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/Database.qml")), "Qt.db.qDatabaseSingleton", 1, 0, "Database");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
