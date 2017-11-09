import QtQuick 2.0
import Qt.loader.qLoaderPageSingleton 1.0

Item {
    anchors.fill: parent
    Text{
        width: 100
        anchors.centerIn: parent
        color: "white"
        fontSizeMode: Text.Fit
        minimumPointSize: 10
        font.pointSize: 30
        text: ""
        function getScores(){
            mainWindow.db.transaction(
                function(tx) {
                    var rs = tx.executeSql('SELECT * FROM Scores ORDER BY score DESC');
                    var r = "";
                    for (var i = 0; i < rs.rows.length; i++) {
                        r += rs.rows.item(i).date + ", " + rs.rows.item(i).score + "\n";
                    }
                    text = r;
                }
            )
        }
        Component.onCompleted: getScores();
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
