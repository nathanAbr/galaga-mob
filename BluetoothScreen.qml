import QtQuick 2.0
import Qt.loader.qLoaderPageSingleton 1.0

Item {
    anchors.fill: parent
    Rectangle{
        color: "transparent"
        anchors.fill: parent
        Column{
            width: parent.width
            anchors.centerIn: parent
            spacing: 10
            Rectangle{
                color: "#AAA"
                width: parent.width / 1.5
                height: 100
                Text{
                    anchors.centerIn: parent
                    text: "Bluetooth Server"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        LoaderPage.source = "qrc:/BluetoothRegistered.qml";
                    }
                }
            }

            Rectangle{
                color: "#AAA"
                width: parent.width / 1.5
                height: 100
                Text{
                    anchors.centerIn: parent
                    text: "Bluetooth Client"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        LoaderPage.source = "qrc:/BluetoothConnect.qml";
                    }
                }
            }
        }
    }
}
