import QtQuick 2.0
import QtBluetooth 5.9

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
        }
    }
}
