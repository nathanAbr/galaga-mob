import QtQuick 2.0

Item {

    property string name
    property string adress

    width: parent.width
    height: 150
    Rectangle{
        color: "transparent"
        anchors.fill: parent
        Text{
            text: name
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {

            }
        }
    }
}
