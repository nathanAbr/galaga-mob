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
        db.transaction(
            function(tx){
                tx.executeSql('CREATE TABLE IF NOT EXISTS Scores(date TEXT, score INTEGER)');
            }
        );
    }

    Image{
        source: "content/fonds.jpg"
        anchors.fill: parent
        autoTransform: true
    }

    Loader{
        id: gameLoader
        anchors.fill: parent
        source: "Menu.qml"
    }

    function multip(a, b){
        return a * b;
    }
}
