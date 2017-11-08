import QtQuick 2.0

Item {
    anchors.fill: parent
    Text{
        width: 100
        anchors.centerIn: parent
        color: "white"
        fontSizeMode: Text.Fit
        minimumPointSize: 10
        font.pointSize: 20
        text: ""
        function getScores(){
            mainWindow.db.transaction(
                function(tx) {
                    var rs = tx.executeSql('SELECT * FROM Scores');
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
}
