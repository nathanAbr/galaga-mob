import QtQuick 2.0

Rectangle{
    color: "red"
    id: gun
    width: 2
    height: 15
    x: 0
    y: 0
    property Grid listEnnemies
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
        for(var i = 0 ; i < listEnnemies.children.length ; i++){
            var enemy = listEnnemies.children[i];
            console.log("Debut");
            console.log(enemy.y);
            console.log(gun.y);
            console.log(enemy.height);
            var yHeight = enemy.y + enemy.height;
            console.log(yHeight);
            if(gun.y >= enemy.y && gun.y <= yHeight){
                console.log("ennemi ok");
                if(gun.x >= enemy.x && gun.x <= enemy.x + enemy.height){
                    console.log("ennemi encore ok");
                    listEnnemies.children[i].destroy();
                    gun.destroy();
                }
            }
        }
    }
    Component.onCompleted: gunShoot.running = true
}
