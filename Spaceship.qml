import QtQuick 2.0

Item {
    width: 50
    height: 50
    x: parent.width / 2 - width
    y: parent.height - ( height + 10 )
    Image{
        width: 50
        height: 50
        source: "/content/spacesheep.png"
    }
    onVisibleChanged: {
        gameLoader.source = "main.qml"
    }
}
