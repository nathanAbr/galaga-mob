import QtQuick 2.6
import QtQuick.Window 2.2
import QtMultimedia 5.9
import QtQuick.Controls 2.2

ApplicationWindow {
    id: mainWindow
    visible: true
    visibility: "FullScreen"
    title: qsTr("Hello World")

    Image{
        source: "content/fonds.jpg"
        anchors.fill: parent
        autoTransform: true
    }

    header: TabBar{
        Rectangle{
            width: 150
            height: 40
            Text{
                width: 100
                anchors.centerIn: parent
                text: qsTr("quit")
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                }
            }
        }
    }

    footer: TabBar{

    }

    Column{
        id: menu
        width: 500
        height: 400
        spacing: 5
        anchors.centerIn: parent
        Repeater{
            model: listMenuButton
            delegate: Rectangle{
                width: 150
                height: 40
                x: menu.width / 2 - width / 2
                color: "transparent"
                radius: 8
                border.color: "#CCC"
                border.width: 2
                Text{
                    text: model.label
                    anchors.centerIn: parent
                    color: "#CCC"
                }
                MouseArea{
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: {
                        menu.visible = false
                        gameLoader.source = model.url
                    }
                }
            }
        }
    }

    ListModel{
        id: listMenuButton
        ListElement{
            label: "PLAY GAME"
            url: "Game.qml"
        }
        ListElement{
            label: "SCORES"
            url: ""
        }
    }

    Loader{
        id: gameLoader
        anchors.fill: parent
    }

    function multip(a, b){
        return a * b;
    }
}
