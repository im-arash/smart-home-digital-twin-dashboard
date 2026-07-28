import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtMultimedia
import Qt5Compat.GraphicalEffects

Item {
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true

    property bool cctvEnabled: false

    // Watch for changes to the property from outside
    onCctvEnabledChanged: {
        if (cctvEnabled) {
            console.log("CCTV started")
            player.source = "udp://127.0.0.1:1234?timeout=2000000&fflags=nobuffer"
            player.play()
        } else {
            console.log("CCTV stopped")
            reconnectTimer.stop()
            player.stop()
            player.source = ""
        }
    }

    Rectangle {
        id: bgRect
        anchors.fill: parent
        radius: 20

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#808080" }
            GradientStop { position: 1.0; color: "#505050" }
        }

        MediaPlayer {
            id: player
            audioOutput: null
            videoOutput: videoOutput

            onErrorOccurred: (error, errorString) => {
                console.log("Player Error detected: " + errorString)

                if (!root.cctvEnabled)
                    return

                if (!reconnectTimer.running) {
                    console.log("Stream lost. Resetting player...")
                    player.stop()
                    player.source = ""
                    reconnectTimer.start()
                }
            }
        }

        Timer {
            id: reconnectTimer
            interval: 3000
            repeat: false

            onTriggered: {
                if (!root.cctvEnabled)
                    return

                console.log("Attempting reconnect...")
                player.source = "udp://127.0.0.1:1234?timeout=2000000&fflags=nobuffer"
                player.play()
            }
        }

        VideoOutput {
            id: videoOutput
            anchors.fill: parent
            fillMode: VideoOutput.PreserveAspectCrop
            visible: false
        }

        Rectangle {
            id: videoMask
            anchors.fill: parent
            radius: 20
            visible: false
        }

        OpacityMask {
            anchors.fill: videoOutput
            source: videoOutput
            maskSource: videoMask
        }
    }
}
