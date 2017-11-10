import QtQuick 2.0
import QtQuick.LocalStorage 2.0

pragma Singleton

Item {
    property var db: LocalStorage.openDatabaseSync("QGalagamob", "1.0", "Save the score", 1000000);
    Component.onCompleted: {
        db.transaction(
            function(tx){
                tx.executeSql('DROP TABLE IF EXISTS Scores');
                tx.executeSql('CREATE TABLE IF NOT EXISTS Scores(date TEXT, score INTEGER, pseudo TEXT)');
            }
        );
    }
}
