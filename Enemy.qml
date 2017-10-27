import QtQuick 2.0

Rectangle {
    width: 50
    height: 50
    property real row
    property real column
    property real customPadding
    property real offset
    property int pointValue
    color: "red"
    x: customPadding + (column * width) + (column * customPadding) + offset
    y: customPadding + (row * width) + (row * customPadding)
}
