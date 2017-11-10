import QtQuick 2.0
import Qt.loader.qLoaderPageSingleton 1.0
import Qt.score.qScoreSingleton 1.0
import Qt.db.qDatabaseSingleton 1.0

Item{
    anchors.fill: parent
    anchors.centerIn: parent

    Column{
        anchors.centerIn: parent
        width: parent.width
        height: 300
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
        Row{
            Rectangle{
                color: "#AAA"
                opacity: 0.6
                width: 100
                height: 40
                radius: 10
                Text{
                    text: "Retry"
                    anchors.centerIn: parent
                    color: "white"
                    font.pointSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        Database.db.transaction(
                            function(tx){
                                var date = new Date();
                                tx.executeSql('INSERT INTO Scores VALUES (?, ?)', ["Le " + date.getDate() + "/" + (date.getMonth()+1) + "/" + date.getFullYear() + " à " + date.getHours() + ":" + date.getMinutes(), Score.score]);
                            }
                        );
                        LoaderPage.url = "Game.qml";
                    }
                }
            }
            Rectangle{
                color: "#AAA"
                opacity: 0.6
                width: 100
                height: 40
                radius: 10
                Text{
                    text: "Quit"
                    anchors.centerIn: parent
                    color: "white"
                    font.pointSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        Database.db.transaction(
                            function(tx){
                                var date = new Date();
                                tx.executeSql('INSERT INTO Scores VALUES (?, ?)', ["Le " + date.getDate() + "/" + (date.getMonth()+1) + "/" + date.getFullYear() + " à " + date.getHours() + ":" + date.getMinutes(), Score.score]);
                            }
                        );
                        LoaderPage.url = "Menu.qml";
                    }
                }
            }
        }
    }
}
