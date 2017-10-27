import QtQuick 2.0

Grid{
    id: listEnnemies
    columns: Math.floor((Math.random() * 8) + 5)
    spacing: 6
    Repeater{
        model: random
        Ennemies{
        }
    }
}
