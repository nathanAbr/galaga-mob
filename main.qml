import QtQuick 2.6
import QtQuick.Window 2.2
import QtMultimedia 5.9
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0
import Qt.loader.qLoaderPageSingleton 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    visibility: "FullScreen"
    title: qsTr("Hello World")

    Image{
        source: "content/background.png"
        anchors.fill: parent
        autoTransform: true
    }

    Loader{
        source: LoaderPage.url
        anchors.fill: parent
    }
}
