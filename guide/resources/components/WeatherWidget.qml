import QtQuick
import QtQuick.Effects
import QtGraphs
import QtQuick.Layouts

Item {
    id: weatherWidgetRoot
    Layout.fillWidth: true
    Layout.fillHeight: true
    // (Ensure you have an explicit width/height here or in the parent if needed in Designer)

    // 1. The Background Layer
    Rectangle {
        anchors.fill: parent
        radius: 20
        antialiasing: true // Smooths the background's own corners
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#808080" }
            GradientStop { position: 1.0; color: "#707070" }
        }
        Text {
            id: name
            text: "23°"
            x: 20
            y: 20
            color: "white"
            font.pixelSize: 50
            font.bold: true
        }
    }

    // 2. The Mask Source
    Rectangle {
        id: roundedMask
        anchors.fill: parent
        radius: 20
        color: "black"
        visible: false
        antialiasing: true
        layer.enabled: true
        layer.samples: 8 // <-- THE FIX: Forces the mask texture to be perfectly smooth
    }

    // 3. The Graph Container
    Item {
        anchors.fill: parent

        layer.enabled: true
        layer.samples: 8 // <-- THE FIX: Smooths the final composited output
        layer.effect: MultiEffect {
            maskEnabled: true
            maskSource: roundedMask
        }

        GraphsView {
            anchors.fill: parent

            // Negative margins push the internal padding out
            anchors.leftMargin: -25
            anchors.rightMargin: -25
            anchors.bottomMargin: -20
            anchors.topMargin: -10

            theme: GraphsTheme {
                backgroundVisible: false
                plotAreaBackgroundVisible: false
                gridVisible: false
                borderColors: ["transparent"]
            }

            axisX: ValueAxis {
                min: 0
                max: 10
                visible: false
                gridVisible: false
                lineVisible: false
                labelsVisible: false
            }

            axisY: ValueAxis {
                min: 0
                max: 50
                visible: false
                gridVisible: false
                lineVisible: false
                labelsVisible: false
            }

            SplineSeries {
                id: myLineSeries
                color: "white"
                width: 6

                XYPoint { x: 0; y: 20 }
                XYPoint { x: 2; y: 24 }
                XYPoint { x: 4; y: 25 }
                XYPoint { x: 6; y: 30 }
                XYPoint { x: 8; y: 28 }
                XYPoint { x: 10; y: 22 }
            }

            AreaSeries {
                upperSeries: myLineSeries
                color: "#909090"
                borderColor: "transparent"
                borderWidth: 0
            }
        }
    }
}
