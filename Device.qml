import QtQuick 2.0
import QtBluetooth 5.9

Item {

    property string name: "Name"
    property string adress
    property BluetoothService bluetoothService

    width: parent.width
    height: 150
    Rectangle{
        color: "transparent"
        anchors.fill: parent
        Column{
            Text{
                text: name
                color: "green"
            }
            Text{
                text: adress
                color: "green"
            }
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                socket.setService(bluetoothService);
                socket.connected = true;
            }
        }
    }

    BluetoothSocket{
        id: socket
        connected: false
    }
}
