import QtQuick 2.0
import QtMultimedia 5.9

Rectangle{
    color: "red"
    id: enemyFire
    width: 2
    height: 15
    x: 0
    y: 0
    property real customPadding

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
                    gun.destroy();
                }
            }
        }
    }
    SoundEffect{
        id: spaceShipExplosion
        source: "content/sounds/explosion.wav"
    }

    onYChanged: {
        if((enemyFire.y + enemyFire.height) >= spaceShip.y && (enemyFire.y + enemyFire.height) <= (spaceShip.y + spaceShip.height)){
            if(enemyFire.x >= spaceShip.x && enemyFire.x <= (spaceShip.x + spaceShip.width)){
                spaceShip.visible = false;
                spaceShipExplosion.play();
                enemyFire.destroy();
            }
        }
    }
    Component.onCompleted: enemeyFireShoot.running = true
}
