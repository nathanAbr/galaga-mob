import QtQuick 2.0
import QtMultimedia 5.9

pragma Singleton

Item {
    property alias enemyExplosion: enemyExplosion
    property alias enemyGun: enemyGun
    property alias spaceshipExplosion: spaceShipExplosion
    property alias spaceshipGun: spaceShipGun
    SoundEffect{
        id: enemyExplosion
        source: ""
    }
    SoundEffect{
        id: spaceShipExplosion
        source: "content/sounds/explosion.wav"
    }
    SoundEffect{
        id: spaceShipGun
        source: "content/sounds/laser_widebeam.wav"
    }
    SoundEffect{
        id: enemyGun
        source: "content/sounds/laser_fastshot.wav"
    }
}
