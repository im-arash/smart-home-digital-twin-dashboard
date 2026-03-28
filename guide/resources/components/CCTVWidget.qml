import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import Qt5Compat.GraphicalEffects

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true

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
            source: "udp://127.0.0.1:1234?timeout=2000000&fflags=nobuffer" // Listen to FFmpeg's stream
            audioOutput: null
            videoOutput: videoOutput

            onErrorOccurred: (error, errorString) => {
                console.log("Player Error detected: " + errorString);

                // Prevent the error spam from triggering the timer multiple times
                if (!reconnectTimer.running) {
                    console.log("Stream lost. Resetting player...");
                    player.stop();

                    // TRICK: Clear the source to force Qt to destroy the broken FFmpeg demuxer
                    player.source = "";

                    reconnectTimer.start();
                }
            }
        }

        Timer {
            id: reconnectTimer
            interval: 3000 // Wait 3 seconds before trying again
            repeat: false
            onTriggered: {
                console.log("Attempting to reconnect to UDP stream...");
                // Re-assign the source and play
                player.source = "udp://127.0.0.1:1234?timeout=2000000&fflags=nobuffer";
                player.play();
            }
        }

        // 1. The Video Output (Hidden, used as source for the mask)
        VideoOutput {
            id: videoOutput
            anchors.fill: parent

            // Changed from Fit to Crop so it completely covers the rectangle
            fillMode: VideoOutput.PreserveAspectCrop
            visible: false // Hidden because the OpacityMask will draw it
        }

        // 2. The Mask Shape (Hidden, acts as our stencil)
        Rectangle {
            id: videoMask
            anchors.fill: parent
            radius: 20 // Must match your parent rectangle's radius
            visible: false
        }

        // 3. The Mask Effect (Combines the video and the stencil)
        OpacityMask {
            anchors.fill: videoOutput
            source: videoOutput
            maskSource: videoMask
        }
    }
}
