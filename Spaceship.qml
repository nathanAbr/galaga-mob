import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import Qt.loader.qLoaderPageSingleton 1.0

Item {
    width: 50
    height: 50
    x: parent.width / 2 - width
    y: parent.height - ( height + 10 )
    property real lives: 3
    Image{
        width: 50
        height: 50
        source: "/content/spacesheep.png"
    }
    onLivesChanged: {
        if (lives == 0){
            LoaderPage.url = "qrc:/GameOver.qml"
        }
    }
}
