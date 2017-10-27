import QtQuick 2.0

Rectangle {
    id: enemy
    width: 50
    height: 50
    color: "red"
    property bool dead: false

    onOpacityChanged: {
        dead = true
    }
}
