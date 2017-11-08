import QtQuick 2.0
import QtMultimedia 5.9

Item {
    anchors.fill: parent
//    SoundEffect{
//        id: soundClickMenu
//        source: "content/sounds/explosion.wav"
//    }

    Column{
        id: menu
        width: 500
        height: 400
        spacing: 5
        anchors.centerIn: parent
        Rectangle{
            id: buttonPlay
            width: 150
            height: 40
            x: parent.width / 2 - width / 2
            color: "#2222DD"
            Text{
                text: "PLAY GAME"
                anchors.centerIn: parent
            }
            MouseArea{
                id: mouseArea
                anchors.fill: parent
                onClicked: {
                    menu.visible = false
                    var component = Qt.createComponent("Game.qml");
                    var sprite = component.createObject(mainWindow);
                    //soundClickMenu.play();
                }
            }
        }
    }
}
