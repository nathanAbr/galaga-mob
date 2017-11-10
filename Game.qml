import QtQuick 2.0
import QtSensors 5.0
import QtMultimedia 5.9
import Qt.SoundManager.qSoundManagerSingleton 1.0
import Qt.score.qScoreSingleton 1.0
import QtQuick.Particles 2.0

Item {
    id: game
    focus: true
    anchors.fill: parent
    property int random: Math.floor((Math.random() * 60) + 40);
    property real customPadding: 10
    property real offset
    property real nbColumn: 8
    property real offsetMin: 0
    property real dir
    property real rightEnemy
    property real leftEnemy
    property real lastCount
    property real level: 0
    property real timeLevelMs: 30000;
    property real timeLevelS: 30;
    property real killedX
    property real killedY
    property bool onPressedShoot: true
    property real onPressedValue: 0
    property real onReleasedShoot: 0

    Component.onCompleted: {
        Score.score = 0;
        createEnemies()
    }

    property bool explode : false
    property bool shootedBool : false

    onExplodeChanged: {
        explosed.burst(150);
        explode = false;
    }

    onShootedBoolChanged: {
        explosedGun.burst(150);
        shootedBool = false;
    }

    ListModel{
        id: listEnemies
    }

    function kill(i){
        var enemyKilled = listEnemies.get(i);
        game.killedX = enemyKilled.customPadding + (enemyKilled.column * enemyKilled.size) + (enemyKilled.column * enemyKilled.customPadding) + enemyKilled.offset + (enemyKilled.size/2);
        game.killedY = enemyKilled.customPadding + (enemyKilled.row * enemyKilled.size) + (enemyKilled.row * enemyKilled.customPadding) + (enemyKilled.size/2);
        game.explode = true;
        listEnemies.remove(i);
    }

    function shooted(varx, vary){
        explosedGun.x = varx;
        explosedGun.y = vary;
        game.shootedBool= true;
    }

    ParticleSystem{
        id: particlesGun

        ImageParticle{
            source: "/content/point.png"
            colorVariation: 0.1
            color: "#00ff400f"
        }

        Emitter{
            id: explosedGun
            size: 6
            sizeVariation: 2
            endSize: 2
            lifeSpan: 200
            lifeSpanVariation: 0
            enabled: false

            velocity: AngleDirection { angle: 270; angleVariation: 360; magnitude: 80; magnitudeVariation: 25 }
        }
    }

    ParticleSystem{
        id: particles

        ImageParticle{
            source: "/content/point.png"
            colorVariation: 0.1
            color: "#00ff400f"
        }

        Emitter{
            id: explosed
            x: game.killedX
            y: game.killedY
            size: 12
            sizeVariation: 4
            endSize: 2
            lifeSpan: 400
            lifeSpanVariation: 0
            enabled: false

            velocity: AngleDirection { angle: 270; angleVariation: 360; magnitude: 80; magnitudeVariation: 25 }
        }
    }

    Row{
        width: parent.width
        height: 100
        spacing: 10
        Text{
            id: scoresView
            width: parent.width / 4 - 30
            text: "Score :" + Score.score.toString()
            color: "white"
            fontSizeMode: Text.Fit
            minimumPointSize: 10
            font.pointSize: 20
            z: 10
        }

        Text{
            id: timerView
            width: parent.width / 4 - 30
            text: "Time :" + game.timeLevelS.toString()
            color: "white"
            fontSizeMode: Text.Fit
            minimumPointSize: 10
            font.pointSize: 20
            z: 10
        }

        Text{
            id: livesView
            width: parent.width / 4 - 30
            text: "Lives :" + spaceShip.lives.toString()
            color: "white"
            fontSizeMode: Text.Fit
            minimumPointSize: 10
            font.pointSize: 20
            z: 10
        }

        Text{
            id: levelView
            width: parent.width / 4 - 30
            text: "Level :" + game.level.toString()
            color: "white"
            fontSizeMode: Text.Fit
            minimumPointSize: 10
            font.pointSize: 20
            z: 10
        }
    }

    Timer {
        interval: 17; running: true; repeat: true;
        onTriggered: {
            moveEnemies();
        }
    }

    Timer {
        interval: 100; running: true; repeat: true;
        onTriggered: shoot()
    }

    Timer {
        id: refreshEnemy
        interval: 30000; running: true; repeat: true;
        onTriggered: {
            game.level--;
            createEnemies();
            spaceShip.lives--;
        }
    }

    function shoot(){
        if(mouse.pressed && onPressedShoot && onReleasedShoot == 0){
            onPressedValue += 100;
            if(onPressedValue <= 5000){
                var component = Qt.createComponent("Gun.qml");
                var sprite = component.createObject(mainWindow, {"x": spaceShip.x + spaceShip.width / 2, "y": spaceShip.y, "listEnemies": listEnemies, "customPadding": game.customPadding, "windowHeight": game.height, "spaceY": spaceShip.y});
                Sounds.spaceshipGun.play();
            }
            else{
                onPressedShoot = false;
            }
        }
        if(!onPressedShoot){
            onReleasedShoot += 100;
            if(onReleasedShoot >= 3000){
                onPressedShoot = true;
                onPressedValue = 0;
                onReleasedShoot = 0;
            }
        }
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
            if (tempMinX < minX){
                minX = tempMinX;
                rightTempIndex = i;
            }
            if (tempMaxX > maxX){
                maxX = tempMaxX;
                leftTempIndex = i;
            }
        }
        game.rightEnemy = rightTempIndex;
        game.leftEnemy = leftTempIndex;
    }

    function moveEnemies(){
        game.timeLevelMs = game.timeLevelMs - 17;
        game.timeLevelS = Math.floor(game.timeLevelMs/1000);
        if (listEnemies.count == 0){
            createEnemies();
            refreshEnemy.restart();
            Score.score += 1000 * game.level;
            spaceShip.lives++;
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
        var chances = Math.max(0.95 - (game.level - 1) * 0.01, 0.80);
        var fire = Math.random() > chances;
        if (fire){
            var component = Qt.createComponent("EnemyFire.qml");
            var i = Math.floor(Math.random() * (listEnemies.count - 1));
            var sprite = component.createObject(mainWindow, {"enemy": listEnemies.get(i), "offset": game.offset});
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
        game.timeLevelMs = 30000;
        game.timeLevelS = 0;
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

    MouseArea{
        id: mouse
        anchors.fill: parent
        hoverEnabled: true

        onPressed: {

        }

        onClicked:{
            if(onReleasedShoot == 0){
                var component = Qt.createComponent("Gun.qml");
                var sprite = component.createObject(mainWindow, {"x": spaceShip.x + spaceShip.width / 2, "y": spaceShip.y, "listEnemies": listEnemies, "customPadding": game.customPadding, "windowHeight": game.height, "spaceY": spaceShip.y});
                Sounds.spaceshipGun.play();
            }
        }
//        onPositionChanged:{
//            spaceShip.x = mouseX;
//            spaceShip.y = mouseY;
//            Score.spaceShipX = spaceShip.x;
//            Score.spaceShipY = spaceShip.y;
//        }
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
            Score.spaceShipX = spaceShip.x;
            Score.spaceShipY = spaceShip.y;
        }
    }

    function calcPitch(x,y,z) {
        return -(Math.atan(y / Math.sqrt(x * x + z * z)) * 57.2957795);
    }
    function calcRoll(x,y,z) {
        return -(Math.atan(x / Math.sqrt(y * y + z * z)) * 57.2957795);
    }
}
