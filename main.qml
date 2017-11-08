import QtQuick 2.6
import QtQuick.Window 2.2
import QtMultimedia 5.9
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0

ApplicationWindow {
    id: mainWindow
    visible: true
    visibility: "FullScreen"
    title: qsTr("Hello World")
    property var db: LocalStorage.openDatabaseSync("QGalagamob", "1.0", "Save the score", 1000000);

    Component.onCompleted: {
        if(!menu.visible){
            menu.visible = true
        }
        db.transaction(
            function(tx){
                tx.executeSql('CREATE TABLE IF NOT EXISTS Scores(date TEXT, score TEXT)');
            }
        );
    }

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
            url: "Scores.qml"
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
