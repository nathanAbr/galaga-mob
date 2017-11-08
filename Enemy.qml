import QtQuick 2.0
import QtMultimedia 5.9

Rectangle {
    width: 50
    height: 50
    property real row
    property real column
    property real customPadding
    property real offset
    property int pointValue
    color: "red"
    x: customPadding + (column * width) + (column * customPadding) + offset
    y: customPadding + (row * width) + (row * customPadding)
//    SoundEffect{
//        id: soundEnemyShoot
//        source: "content/sounds/laser_fastshot.wav"
//    }
    Timer{
        interval:  Math.floor((Math.random() * 10000) + 4000)
        running: true
        repeat: true
        onTriggered: {
            var component = Qt.createComponent("EnemyFire.qml");
            var sprite = component.createObject(mainWindow, {"x": parent.x + parent.width / 2, "y": parent.y});
            ////    SoundEffect{
            //        id: spaceShipExplosion
            //        source: "content/sounds/explosion.wav"
            //    }soundEnemyShoot.play();
        }
    }
}
