import QtQuick 2.6
import QtQuick.Window 2.2
import QtMultimedia 5.9
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0
import Qt.loader.qLoaderPageSingleton 1.0
import QtQuick.Particles 2.0

ApplicationWindow {
    id: mainWindow
    visible: true
    visibility: "FullScreen"
    title: qsTr("Hello World")

    Rectangle {
        focus: true
        anchors.fill: parent
        color: 'black'

        ParticleSystem {
            id: particleSystem
        }

        Emitter {
            id: emitter
            anchors.top: parent.top
            width: parent.width
            height: 10
            system: particleSystem
            group: 'star0'
            emitRate: 10
            lifeSpan: 8000
            lifeSpanVariation: 400
            size: 32
            sizeVariation: 16
            endSize: 48
            //velocity: AngleDirection { angle: 270; magnitude: 150; magnitudeVariation: 10 }
            velocity: AngleDirection { angle: 90; magnitude: 150; magnitudeVariation: 50}
        }

        ImageParticle{
            source: "/content/star1.png"
            groups: ['star0']
            system: particleSystem
            rotation: 0
            rotationVariation: 45
            rotationVelocity: 15
            rotationVelocityVariation: 15
            entryEffect: ImageParticle.Scale
        }
    }

    Loader{
        source: LoaderPage.url
        anchors.fill: parent
    }
}
