import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtGraphs
import guide

Item {
    id: weatherWidgetRoot
    Layout.fillWidth: true
    Layout.preferredHeight: 180

    WeatherModel {id: weatherModel}

    // 1. The Background Layer
    Rectangle {
        anchors.fill: parent
        radius: 20
        antialiasing: true
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#808080" }
            GradientStop { position: 1.0; color: "#707070" }
        }
        Text {
            text: weatherModel.currentTemperature + "°"
            x: 20
            y: 10
            color: "white"
            font.pixelSize: 40
            font.bold: true
        }

        Text {
            text: " / " + weatherModel.currentLowTemperature + "°"
            x: 80
            y: 30
            color: "#dddddd"
            font.pixelSize: 20
        }

        Text{
            x: 30
            y: 60
            MaterialIcon {
                anchors.centerIn: parent
                icon: "wb_sunny"
                size: 12
                iconColor: "#dddddd"
            }
        }

        Text {
            text: weatherModel.currentDay
            x: 40
            y: 60
            color: "#dddddd"
            font.pixelSize: 12
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

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true
            Layout.margins: 20
            spacing: 42

            Repeater {
                model: weatherModel

                delegate: Column {
                    // spacing: 1

                    Text {
                        text: highTemperature + "°"
                        color: "white"
                        font.bold: true
                        font.pixelSize: 14
                    }

                    Text {
                        text: lowTemperature + "°"
                        color: "#dddddd"
                        font.pixelSize: 12
                    }

                    Text {
                        text: Qt.formatDate(date, "ddd")
                        color: "white"
                        font.pixelSize: 12
                    }
                }
            }
        }
    }

}
