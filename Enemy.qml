import QtQuick 2.0
import QtMultimedia 5.9

Item {
    width: 50
    height: 50
    property real row
    property real column
    property real customPadding
    property real offset
    property int pointValue

    x: customPadding + (column * width) + (column * customPadding) + offset
    y: customPadding + (row * width) + (row * customPadding)

//    SoundEffect{
//        id: soundEnemyShoot
//        source: "content/sounds/laser_fastshot.wav"
//    }

    Image{
        width: 50
        height: 50
        source: "/content/enemy1.png"
        transform: Rotation { origin.x: 25; origin.y: 25; angle: 180}
    }

    Timer{
        interval:  Math.floor((Math.random() * 10000) + 4000)
        running: true
        repeat: true
        onTriggered: {
            var component = Qt.createComponent("EnemyFire.qml");
            var sprite = component.createObject(mainWindow, {"x": parent.x + parent.width / 2, "y": parent.y});
            //soundEnemyShoot.play();
        }
    }
}
