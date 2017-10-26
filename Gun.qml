import QtQuick 2.0

Rectangle{
    color: "red"
    id: gun
    width: 2
    height: 15
    x: 0
    y: 0
    SequentialAnimation{
        id: gunShoot
        running: false

        NumberAnimation {
            target: gun
            property: "y"
            duration: 1000
            to: 0 - gun.height
            onRunningChanged: {
                if(!running){
                    gun.destroy();
                }
            }
        }
    }
    Component.onCompleted: gunShoot.running = true
}
