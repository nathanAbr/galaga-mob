import QtQuick 2.0
import QtSensors 5.0
import QtMultimedia 5.9

Item {
    id: game
    anchors.fill: parent
    property int random: Math.floor((Math.random() * 60) + 40);
    property real customPadding: 10
    property real offset
    property real nbColumn: 16
    property real offsetMin: 0
    property real dir
    property real rightEnemy
    property real leftEnemy
    property real lastCount
    property real level: 0
    property int scores: 0

    Component.onCompleted: createEnemies()

    ListModel{
        id: listEnemies
    }

    Text{
        id: scoresView
        width: 200
        text: "Scores :" + game.scores.toString()
        color: "black"
        fontSizeMode: Text.Fit
        minimumPointSize: 10
        font.pointSize: 20
        z: 10
    }

    Timer {
        interval: 17; running: true; repeat: true;
        onTriggered: moveEnemies()
    }

    Timer {
        interval: 20000; running: true; repeat: true;
        onTriggered: createEnemies()
    }

    function getLeftAndRightEnemies(){
        var rightTempIndex = 0;
        var leftTempIndex = 0;
        var rightTemp = listEnemies.get(rightTempIndex);
        var leftTemp = listEnemies.get(leftTempIndex);
        var minX = rightTemp.customPadding + (rightTemp.column * rightTemp.size) + (rightTemp.column * rightTemp.customPadding) + rightTemp.offset;
        var maxX = leftTemp.customPadding + (leftTemp.column * leftTemp.size) + (leftTemp.column * leftTemp.customPadding) + leftTemp.offset + leftTemp.size;

        for (var i = 0 ; i < listEnemies.count ; i++){
            var enemy = listEnemies.get(i);
            rightTemp = listEnemies.get(rightTempIndex);
            leftTemp = listEnemies.get(leftTempIndex);
            var tempMinX = enemy.customPadding + (enemy.column * enemy.size) + (enemy.column * enemy.customPadding) + enemy.offset;
            var tempMaxX = tempMinX + enemy.size;
            console.log('debut');
            console.log(maxX);
            console.log(tempMaxX);
            if (tempMinX < minX){
                minX = tempMinX;
                rightTempIndex = i;
            }
            if (tempMaxX > maxX){
                maxX = tempMaxX;
                leftTempIndex = i;
            }
        }
        console.log(rightTemp.row);
        console.log(leftTemp.row);
        console.log(rightTemp.column);
        console.log(leftTemp.column);
        game.rightEnemy = rightTempIndex;
        game.leftEnemy = leftTempIndex;
        console.log('fin');
    }

    function moveEnemies(){
        if (listEnemies.count == 0){
            createEnemies();
            return;
        }
        if (listEnemies.count != game.lastCount){
            game.getLeftAndRightEnemies();
        }

        var rand = Math.random() * 100;
        if(rand > 99){
            game.dir = (game.dir == 0 ? 1 : 0);
        }
        var vitesse = -1;
        for (var i = 0 ; i < game.dir ; i ++){
            vitesse = vitesse * (-1);
        }

        var minEnemy = listEnemies.get(game.rightEnemy);
        var maxEnemy = listEnemies.get(game.leftEnemy);
        var minX = minEnemy.customPadding + (minEnemy.column * minEnemy.size) + (minEnemy.column * minEnemy.customPadding) + minEnemy.offset;
        var maxY = maxEnemy.customPadding + (maxEnemy.column * maxEnemy.size) + (maxEnemy.column * maxEnemy.customPadding) + maxEnemy.offset + maxEnemy.size;
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
        game.offset = listEnemies.get(0).offset;
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
        game.level++;
        var rand = Math.floor((Math.random() * 60) + 40);
        var tempOffset = (game.offset != null ? game.offset : 0);
        for (var i = 1 ; i < rand ; i++){
            listEnemies.append(
                        {
                            "row" : yi,
                            "column" : xi,
                            "customPadding": game.customPadding,
                            "offset": tempOffset,
                            "size": 50,
                            "pointValue": 50
                        });
            xi++;
            if (i % columnMax == 0){
                yi++;
                xi = 0;
            }
        }
        game.lastCount = listEnemies.count;
        game.getLeftAndRightEnemies();
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
