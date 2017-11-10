import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import Qt.loader.qLoaderPageSingleton 1.0
import QtQuick.Particles 2.0

Item {
    id: spaceShip
    width: 50
    height: 50
    x: parent.width / 2 - width
    y: parent.height - ( height + 10 )
    property real lives: 3
    property bool explode : false

    onExplodeChanged: {
        explosed.burst(150);
        explode = false;
    }

    Image{
        width: 50
        height: 50
        source: "/content/spacesheep.png"
    }

    onLivesChanged: {
        if (lives == 0){
            explode = true;
            LoaderPage.url = "qrc:/GameOver.qml"
            //gameOver.killed(spaceShip.x + spaceShip.width / 2, spaceShip.y + spaceShip.height / 2);
        }
    }
}
