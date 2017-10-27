import QtQuick 2.0
import QtSensors 5.0
import QtMultimedia 5.9

Item {
    id: game
    anchors.fill: parent
    property int random: Math.floor((Math.random() * 30) + 20);
    property real customPadding: 10
    property real offsetMax
    property real nbColumn: 8
    property real offsetMin: 0
    property real dir

    Component.onCompleted: createEnemies()

    ListModel{
        id: listEnemies
    }

    Timer {
        interval: 17; running: true; repeat: true;
        onTriggered: moveEnemies()
    }

    function moveEnemies(){
        if (listEnemies.count == 0){
            return;
        }
        var rand = Math.random() * 100;
        console.debug(rand);
        if(rand > 99){
            game.dir = (game.dir == 0 ? 1 : 0);
        }
        var vitesse = -1;
        for (var i = 0 ; i < game.dir ; i ++){
            vitesse = vitesse * (-1);
        }

        var minEnemy = listEnemies.get(0);
        var maxEnemy;
        if (listEnemies.count < 7){
            maxEnemy = listEnemies.get(listEnemies.count - 1);
        }else{
            maxEnemy = listEnemies.get(7);
        }
        var minX = minEnemy.customPadding + (minEnemy.column * minEnemy.size) + (minEnemy.column * minEnemy.customPadding) + minEnemy.offset
        var maxY = maxEnemy.customPadding + (maxEnemy.column * maxEnemy.size) + (maxEnemy.column * maxEnemy.customPadding) + maxEnemy.offset + maxEnemy.size
        if (game.dir == 0){
            if (minX + vitesse < 0){
                game.dir = (game.dir == 0 ? 1 : 0);
            }
        }else{
            if (maxY + vitesse > game.width){
                game.dir = (game.dir == 0 ? 1 : 0);
            }
        }
        vitesse = -1;
        for (var i = 0 ; i < game.dir ; i ++){
            vitesse = vitesse * (-1);
        }

        for(var i = 0 ; i < listEnemies.count ; i++){
            listEnemies.get(i).offset += (vitesse*3);
        }
    }

    Repeater{
        model: listEnemies
        Enemy{
            row: model.row
            column: model.column
            customPadding: game.customPadding
            offset: model.offset
            width: model.size
            height: model.size
        }
    }

    function createEnemies(){
        var xi = 0;
        var yi = 0;
        var columnMax = game.nbColumn;
        game.dir = 1;
        for (var i = 1 ; i < random ; i++){
            listEnemies.append(
                        {
                            "row" : yi,
                            "column" : xi,
                            "customPadding": game.customPadding,
                            "offset": 0,
                            "size": 50
                        });
            xi++;
            if (i % columnMax == 0){
                yi++;
                xi = 0;
            }
        }
        console.log('init finished');
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
            var sprite = component.createObject(mainWindow, {"x": spaceShip.x + spaceShip.width / 2, "y": spaceShip.y, "listEnemies": listEnemies, "customPadding": game.customPadding});
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
