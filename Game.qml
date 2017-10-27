import QtQuick 2.0
import QtSensors 5.0
import QtMultimedia 5.9

Item {
    id: gameScreen
    anchors.fill: parent
    property int random: Math.floor((Math.random() * 30) + 20);
    property alias ennemies: listEnnemies
    Spaceship{
        id: spaceShip
        width: 50
        height: 50
    }

    ListEnnemies{
        id: listEnnemies
        width: parent.width
        height: 250
    }

    SoundEffect{
        id: soundShoot
        source: "content/sounds/laser_widebeam.wav"
    }

    MouseArea{
        anchors.fill: parent
        onClicked:{
            var component = Qt.createComponent("Gun.qml");
            var sprite = component.createObject(mainWindow, {"x": spaceShip.x + spaceShip.width / 2, "y": spaceShip.y});
            soundShoot.play();
        }
    }

    Accelerometer{
        id: accel
        dataRate: 200
        active: true

        onReadingChanged:{
            var xPos = spaceShip.x + calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * .1
            var yPos = spaceShip.y - calcPitch(accel.reading.x, accel.reading.y, accel.reading.z) * .1

            if(xPos > mainWindow.width - spaceShip.width)
                xPos = mainWindow - spaceShip.width
            if(xPos < 0)
                xPos = 0
            if(yPos < 18)
                yPos = 18
            if(yPos > mainWindow.height - spaceShip.height)
                yPos = mainWindow.height - spaceShip.height

            spaceShip.x = xPos
            spaceShip.y = yPos
        }
    }

    function calcPitch(x,y,z) {
        return -(Math.atan(y / Math.sqrt(x * x + z * z)) * 57.2957795);
    }
    function calcRoll(x,y,z) {
        return -(Math.atan(x / Math.sqrt(y * y + z * z)) * 57.2957795);
    }
//    function destroyEnnemy(index){
//        gameScreen.listEnnemies.children[index].destroy();
//    }
}
