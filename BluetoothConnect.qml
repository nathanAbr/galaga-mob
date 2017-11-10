import QtQuick 2.0
import QtBluetooth 5.9
import Qt.loader.qLoaderPageSingleton 1.0

Item {

    anchors.fill: parent
    property BluetoothService current

    BluetoothDiscoveryModel{
        id: discovery
        running: true
        discoveryMode: BluetoothDiscoveryModel.DeviceDiscovery
    }

    ListView{
        id: listDevice
        model: discovery
        width: parent.width / 2
        height: parent.height
        anchors.centerIn: parent
        delegate: Device{
            name: deviceName
            adress: discovery.remoteAddress
            bluetoothService: service
        }
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
