import QtQuick 2.0

Item {
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
}
