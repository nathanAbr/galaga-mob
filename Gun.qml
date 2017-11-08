import QtQuick 2.0

Rectangle{
    color: "red"
    id: gun
    width: 5
    height: 15
    x: 0
    y: 0
    property ListModel listEnemies
    property real customPadding

    SequentialAnimation{
        id: gunShoot
        running: false
        NumberAnimation{
            target: gun
            properties: "y"
            duration: 1000
            to: 0 - gun.height
            onRunningChanged: {
                if(!running){
                    gun.destroy();
                }
            }
        }
    }
    onYChanged: {
        for(var i = 0 ; i < listEnemies.count ; i++){
            var data = listEnemies.get(i);
            var enemyX = data.customPadding + (data.column * data.size) + (data.column * data.customPadding) + data.offset
            var enemyY = data.customPadding + (data.row * data.size) + (data.row * data.customPadding)
            var yHeight = enemyY + data.size;
            var xHeight = enemyX + data.size;
            if(gun.y >= enemyY && gun.y <= yHeight){
                if(gun.x >= enemyX && gun.x <= xHeight){
                    game.scores = game.scores + data.pointValue;
                    listEnemies.remove(i);
                    gun.destroy();
                }
            }
        }
    }
    Component.onCompleted: gunShoot.running = true
}
