import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtGraphs

Item {
    id: weatherWidgetRoot
    Layout.fillWidth: true
    Layout.fillHeight: true

    // 1. The Background Layer (Covers the entire widget)
    Rectangle {
        anchors.fill: parent
        radius: 20
        antialiasing: true
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#606060" }
            GradientStop { position: 1.0; color: "#505050" }
        }
    }

    // Main Layout
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Title Text
        Text {
            text: "Energy(kwh)"
            color: "white"
            font.pixelSize: 16
            font.bold: true
            Layout.margins: 20
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
        }

        // 3. The Graph Container (Takes up the remaining space)
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            // 2. The Mask Source (Applied specifically to the graph area)
            Rectangle {
                id: roundedMask
                anchors.fill: parent
                // Keeping the radius to match the bottom corners of the background
                radius: 20
                color: "black"
                visible: false
                antialiasing: true
                layer.enabled: true
                layer.samples: 8
            }

            Item {
                anchors.fill: parent

                layer.enabled: true
                layer.samples: 8
                layer.effect: MultiEffect {
                    maskEnabled: true
                    maskSource: roundedMask
                }

                GraphsView {
                    anchors.fill: parent

                    // Fine-tuned negative margins
                    anchors.leftMargin: -20
                    anchors.bottomMargin: -15
                    anchors.rightMargin: 0
                    anchors.topMargin: -10

                    theme: GraphsTheme {
                        labelTextColor: "white"
                        // Makes the graph background fully transparent
                        backgroundVisible: false
                        plotAreaBackgroundVisible: false
                        gridVisible: false
                        borderColors: ["transparent"]

                        // Make the labels very small
                        labelFont.pixelSize: 10

                        // Set the color for the single BarSet (LightBlue)
                        seriesColors: [Material.color(Material.LightBlue)]
                    }

                    axisX: BarCategoryAxis {
                        categories: ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"]
                        gridVisible: false
                        subGridVisible: false
                        lineVisible: false
                    }

                    axisY: ValueAxis {
                        min: 0
                        max: 40
                        tickInterval: 8
                        subTickCount: 0
                        gridVisible: false
                        lineVisible: false
                    }

                    BarSeries {
                        BarSet {
                            values: [32, 24, 16, 8, 40, 24, 32]
                        }
                    }
                }
            }
        }
    }
}
