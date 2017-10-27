import QtQuick 2.0
import QtSensors 5.0
import QtMultimedia 5.9

Item {
    id: game
    anchors.fill: parent
    property int random: Math.floor((Math.random() * 30) + 20);
    property ListModel listEnemies
    property real customPadding: 10

    Component.onCompleted: createEnemies();

    Repeater{
        model: game.listEnemies
        Rectangle{
            width: model.width
            height: model.height
            color: "red"
            x: model.x
            y: model.y
        }
    }

    function createEnemies(){
        var xi = 0;
        var yi = 0;
        var columnMax = 8;
        var component = Qt.createComponent("Enemy.qml");
        var newModel = Qt.createQmlObject('import QtQuick 2.2; \ ListModel {}', parent);
        for (var i = 1 ; i < random ; i++){
            var enemy = component.createObject(mainWindow, {"row" : yi, "column" : xi});
            enemy.x = game.customPadding + (xi * enemy.width) + (xi * game.customPadding);
            enemy.y = game.customPadding + (yi * enemy.width) + (yi * game.customPadding);
            newModel.append(enemy);
            xi++;
            if (i % columnMax == 0){
                yi++;
                xi = 0;
            }
            console.log(enemy.toString());
        }
        game.listEnemies = newModel;
        console.log(game.listEnemies.count);
    }

    Spaceship{
        id: spaceShip
        width: 50
        height: 50
    }

    SoundEffect{
        id: soundShoot
        source: "content/sounds/laser_widebeam.wav"
    }

    MouseArea{
        anchors.fill: parent
        onClicked:{
            var component = Qt.createComponent("Gun.qml");
            var sprite = component.createObject(mainWindow, {"x": spaceShip.x + spaceShip.width / 2, "y": spaceShip.y, "listEnemies": game.listEnemies});
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
}
