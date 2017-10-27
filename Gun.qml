import QtQuick 2.0

Rectangle{
    color: "red"
    id: gun
    width: 2
    height: 15
    x: 0
    y: 0
    property ListModel listEnemies

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
        console.log(listEnemies);
        for(var i = 0 ; i < listEnemies.count ; i++){
            var enemy = listEnemies.get(i);
            var yHeight = enemy.y + enemy.height;
            var xHeight = enemy.x + enemy.height;
            if(gun.y >= enemy.y && gun.y <= yHeight){
                if(gun.x >= enemy.x && gun.x <= xHeight){
                    console.log("removed");
                    listEnemies.remove(i);
                    gun.destroy();
                }
            }
        }
    }
    Component.onCompleted: gunShoot.running = true
}
