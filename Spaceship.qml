import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    width: 50
    height: 50
    x: parent.width / 2 - width
    y: parent.height - ( height + 10 )
    property real lives: 3
    Image{
        width: 50
        height: 50
        source: "/content/spacesheep.png"
    }
    onVisibleChanged: {
        mainWindow.db.transaction(
            function(tx){
                var date = new Date();
                tx.executeSql('INSERT INTO Scores VALUES (?, ?)', ["Le " + date.getDate() + "/" + (date.getMonth()+1) + "/" + date.getFullYear() + " à " + date.getHours() + ":" + date.getMinutes(), game.scores + " points"]);
            }
        );
        gameLoader.source = "main.qml";
    }
    onLivesChanged: {
        if (lives == 0){
            mainWindow.db.transaction(
                function(tx){
                    var date = new Date();
                    tx.executeSql('INSERT INTO Scores VALUES (?, ?)', ["Le " + date.getDay() + " " + date.getMonth() + " " + date.getFullYear(), game.scores + " points"]);
                }
            );
            gameLoader.source = "main.qml";
        }
    }
}
