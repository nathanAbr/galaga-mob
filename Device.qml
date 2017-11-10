import QtQuick 2.0

Item {

    property string name: "Name"
    property string adress

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

            }
        }
    }
}
