import QtQuick
import QtQuick3D
import QtQuick.Controls
import QtQuick.Controls.Material
import Home3d
import "interior"

Window {
    id: mainWindow
    x: 0
    y: (Screen.height - height) / 2
    width: 640
    height: 480
    visible: true
    title: qsTr("Home 3D")
    color: "#222222"


    FFmpegStreamer { id: ffmpegStreamer }

    Loader {
        id: sceneLoader
        anchors.fill: parent
        asynchronous: true
        source: "Main3dScene.qml"
        visible: item && item.exteriorLoader.item !== null
    }

    Rectangle {
        anchors.fill: parent
        color: "#222222"
        Text {
            anchors.centerIn: parent
            text: "Loading 3D Scene..."
            font.pixelSize: 24
            color: "white"
        }
        visible: sceneLoader.status !== Loader.Ready || (sceneLoader.item && sceneLoader.item.exteriorLoader.item === null)
    }

    // Secondary View3D for CCTV
    View3D {
        id: cctvView
        width: 450
        height: 600
        z: -1
        visible: true

        camera: sceneLoader.item ? sceneLoader.item.interiorCamera1 : null
        environment: sceneLoader.item ? sceneLoader.item.sceneEnvironment : null
        importScene: sceneLoader.item ? sceneLoader.item.sharedScene : null

        ThermostatTintOverlay {
                    anchors.fill: parent

                    // Fallback to 24.0 and "off" if the scene isn't loaded yet
                    roomTemperature: sceneLoader.item ? sceneLoader.item.thermostat.roomTemperature : 24.0
                    mode: sceneLoader.item ? sceneLoader.item.thermostat.activeState : "off"
                }
    }

    // FFmpeg Frame Grabber
    Timer {
        interval: 66
        repeat: true
        running: sceneLoader.status === Loader.Ready

        onTriggered: {
            cctvView.grabToImage(function(result) {
                if (result && result.image) {
                    ffmpegStreamer.pushFrame(result.image)
                }
            })
        }
    }

    // Column {
    //     Button {
    //         text: "camera"
    //         onClicked: {
    //             if (sceneLoader.item) {
    //                 sceneLoader.item.view3D.camera = sceneLoader.item.view3D.camera === sceneLoader.item.interiorCamera1
    //                                                  ? sceneLoader.item.sceneCamera
    //                                                  : sceneLoader.item.interiorCamera1
    //             }
    //         }
    //     }
    // }
}
