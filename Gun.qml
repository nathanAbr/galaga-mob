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
            property: "y"
            duration: 1000
            to: 0 - gun.height
            onPropertyChanged: {
                console.log("change");
                for(var i = 0;i>listEnnemies.children.lenght;i++){
                    if(listEnnemies.children[i].y === gun.y - gun.height){
                        console.log("ennemi ok");
                        if(gun.x >= listEnnemies.children[i].x && gun.x <= listEnnemies.children[i].x + listEnnemies.children[i].height){
                            console.log("ennemi encore ok");
                            listEnnemies.children[i].destroy();
                            gun.destroy();
                        }
                    }
                }
            }
            onRunningChanged: {
                if(!running){
                    gun.destroy();
                }
            }
        }
    }
    Component.onCompleted: gunShoot.running = true
}
