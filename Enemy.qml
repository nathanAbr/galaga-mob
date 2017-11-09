import QtQuick 2.0
import QtMultimedia 5.9
import QtQuick.Particles 2.0

Item {
    width: 50
    height: 50
    property real row
    property real column
    property real customPadding
    property real offset
    property int pointValue

    x: customPadding + (column * width) + (column * customPadding) + offset
    y: customPadding + (row * width) + (row * customPadding)

    Image{
        id: enemyImg
        width: 50
        height: 50
        source: "/content/enemy1.png"
        transform: Rotation { origin.x: 25; origin.y: 25; angle: 180}
    }
}
