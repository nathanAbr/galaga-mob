import QtQuick 2.0
import Qt.loader.qLoaderPageSingleton 1.0
import Qt.score.qScoreSingleton 1.0

Item{
    width: childrenRect.width + 100
    height: childrenRect.height + 100
    anchors.centerIn: parent

    Text {
        font.pointSize: 60
        color: 'white'
        text: '<b>GAME OVER</b>';
    }
    Text {
        font.pointSize: 30
        color: 'white'
        text: 'Your score : ' + Score.score;
    }
    Rectangle{
        color: "#AAA"
        opacity: 0.6
        width: 100
        height: 40
        radius: 10
        anchors.centerIn: parent
        Text{
            text: "Retry"
            anchors.centerIn: parent
            color: "white"
            font.pointSize: 20
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                LoaderPage.url = "Game.qml";
            }
        }
    }
}
