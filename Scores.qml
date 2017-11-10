import QtQuick 2.0
import QtQuick.Controls 2.2
import Qt.loader.qLoaderPageSingleton 1.0
import Qt.db.qDatabaseSingleton 1.0

Item {
    anchors.fill: parent

    Component.onCompleted: getScore()

    ListModel{
        id: scoresList
    }

    Rectangle{
        width: parent.width
        height: parent.height / 2
        anchors.centerIn: parent
        color: 'transparent'

        Component{
            id: scoreDelegate

            Item{
                width: childrenRect.width
                height: childrenRect.height
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
//                        Text { text: '<b>' + name + '</b>: ' + score}
//                        Text { text: date }
                    Text {
                        font.pointSize: 16
                        text: '<b>' + name + '</b> : ' +score
                        color: 'white'
                    }
                    Text {
                        color: 'white'
                        text: date
                    }
                }
            }
        }

        ListView{
            anchors.fill: parent
            model: scoresList
            delegate: scoreDelegate
            clip: true
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds
            ScrollBar.vertical: ScrollBar {}
        }
    }

    function getScore(){
        Database.db.transaction(
            function(tx) {
                var rs = tx.executeSql('SELECT * FROM Scores ORDER BY score DESC');
                for (var i = 0; i < rs.rows.length; i++) {
                    scoresList.append(
                                {
                                    "date" : rs.rows.item(i).date,
                                    "score" : rs.rows.item(i).score,
                                    "name": rs.rows.item(i).pseudo
                                });
                }
            }
        );
    }

    Rectangle{
        color: "#AAA"
        opacity: 0.6
        width: 100
        height: 40
        radius: 10
        Text{
            text: "Back"
            anchors.centerIn: parent
            color: "white"
            fontSizeMode: Text.Fit
            minimumPointSize: 10
            font.pointSize: 20
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                LoaderPage.url = "Menu.qml";
            }
        }
    }
}
