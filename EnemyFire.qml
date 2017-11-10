import QtQuick 2.0
import QtMultimedia 5.9
import Qt.SoundManager.qSoundManagerSingleton 1.0
import QtQuick.Particles 2.0

Rectangle{
    color: "red"
    id: enemyFire
    width: 5
    height: 15
    property QtObject enemy
    property real offset
    property bool touched: false

    SequentialAnimation{
        id: enemeyFireShoot
        running: false
        NumberAnimation{
            target: enemyFire
            properties: "y"
            duration: Math.floor((Math.random() * 2000) + 700)
            to: mainWindow.height + enemyFire.height
            onRunningChanged: {
                if(!running){
                    enemyFire.destroy();
                }
            }
        }
    }

    onYChanged: {
        if((enemyFire.y + enemyFire.height) >= spaceShip.y && (enemyFire.y + enemyFire.height) <= (spaceShip.y + spaceShip.height) && !touched){
            if(enemyFire.x >= spaceShip.x && enemyFire.x <= (spaceShip.x + spaceShip.width)){
                Sounds.spaceshipExplosion.play();
                game.shooted(enemyFire.x, enemyFire.y + enemyFire.height);
                spaceShip.lives = spaceShip.lives - 1;
                touched = true;
                enemyFire.destroy();
            }
        }
    }

    Component.onCompleted: init()

    function init(){
        enemyFire.x = enemy.customPadding + (enemy.column * enemy.size) + (enemy.column * enemy.customPadding) + enemyFire.offset + (enemy.size  / 2);
        enemyFire.y = enemy.customPadding + (enemy.row * enemy.size) + (enemy.row * enemy.customPadding) + enemy.size;
        enemeyFireShoot.running = true;
    }
}
