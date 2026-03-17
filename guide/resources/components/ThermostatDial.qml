import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Shapes

Item {
    Layout.preferredWidth: 300
    Layout.fillHeight: true

    component CircularIconButton : Rectangle {
        property string iconName
        property int size: 50
        signal clicked()

        width: size
        height: size
        radius: size / 2
        color: tapHandler.pressed ? "#404040" : (hoverHandler.hovered ? "#808080" : "#606060")

        MaterialIcon {
            anchors.centerIn: parent
            icon: iconName
        }

        HoverHandler { id: hoverHandler }
        TapHandler {
            id: tapHandler
            onTapped: parent.clicked()
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: 20
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#707070" }
            GradientStop { position: 1.0; color: "#505050" }
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 15

            // -- Header --
            RowLayout {
                Layout.margins: 20
                Layout.fillWidth: true

                Text {
                    text: "Thermostat"
                    color: "white"
                    font.pixelSize: 16
                    font.bold: true
                }

                Item { Layout.fillWidth: true } // spacer

                Switch {}
            }

            // -- Dial Control --
            Dial {
                id: control
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredWidth: 250
                Layout.preferredHeight: 250
                from: 10
                to: 35
                stepSize: 1
                value: 20

                background: Item {
                    Layout.preferredWidth: 250
                    Layout.preferredHeight: 250

                    // Base full circle border (Gray)
                    Rectangle {
                        anchors.fill: parent
                        radius: width / 2
                        color: "transparent"
                        border.width: 15
                        border.color: "#909090"
                        antialiasing: true
                    }

                    // Active filled border (Blue) based on value
                    Shape {
                        anchors.fill: parent
                        antialiasing: true
                        layer.enabled: true
                        layer.samples: 8

                        ShapePath {
                            fillColor: "transparent"
                            strokeColor: "deepskyblue"
                            strokeWidth: 15
                            capStyle: ShapePath.FlatCap

                            PathAngleArc {
                                centerX: 125
                                centerY: 125
                                radiusX: 117.5
                                radiusY: 117.5
                                startAngle: 130
                                sweepAngle: 280 * ((control.value - control.from) / (control.to - control.from))
                            }
                        }
                    }

                    // Repeater for the tick marks
                    Repeater {
                        id: tickRepeater
                        model: (control.to - control.from) / control.stepSize + 1

                        Rectangle {
                            id: tick
                            width: 3
                            height: (index % 5 === 0) ? 14 : 8
                            color: (index + control.from) <= control.value ? "deepskyblue" : "#d0d0d0"
                            antialiasing: true

                            x: parent.width / 2 - width / 2
                            y: parent.height / 2 - height / 2

                            transform: [
                                Translate { y: -parent.height / 2 + 25 },
                                Rotation {
                                    angle: -140 + (index / (tickRepeater.model - 1)) * 280
                                    origin.x: tick.width / 2
                                    origin.y: tick.height / 2
                                }
                            ]
                        }
                    }
                }

                // Center Text Display
                Item {
                    anchors.centerIn: parent

                    Text {
                        id: numberText
                        text: control.value.toFixed(0)
                        color: "white"
                        font.pixelSize: 50
                        font.bold: true
                        anchors.centerIn: parent
                    }

                    Text {
                        text: "°"
                        color: "white"
                        font.pixelSize: 28
                        anchors.left: numberText.right
                        anchors.leftMargin: 2
                        anchors.top: numberText.top
                    }
                }

                // Draggable Handle
                handle: Rectangle {
                    id: handleItem
                    x: control.background.x + control.background.width / 2 - width / 2
                    y: control.background.y + control.background.height / 2 - height / 2
                    width: 30
                    height: 30
                    color: control.pressed ? "dodgerblue" : "LightBlue"
                    radius: 15 // width / 2
                    antialiasing: true
                    opacity: control.enabled ? 1 : 0.3

                    transform: [
                        Translate { y: -Math.min(control.background.width, control.background.height) * 0.47 },
                        Rotation {
                            angle: control.angle
                            origin.x: handleItem.width / 2
                            origin.y: handleItem.height / 2
                        }
                    ]

                    // Inner dot
                    Rectangle {
                        anchors.centerIn: parent
                        width: 15
                        height: 15
                        radius: 7.5 // width / 2
                        color: "#909090"
                    }
                }
            }

            // -- Increase / Decrease Buttons --
            RowLayout {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                spacing: 20

                CircularIconButton {
                    size: 36
                    iconName: "check_indeterminate_small" // Acts as minus
                    onClicked: control.decrease()
                }

                CircularIconButton {
                    size: 36
                    iconName: "add"
                    onClicked: control.increase()
                }
            }

            // -- Action Buttons --
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10

                Text {
                    text: "Actions"
                    color: "white"
                    Layout.leftMargin: 20
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 15

                    Item { Layout.fillWidth: true } // left spacer

                    CircularIconButton { iconName: "mode_fan"; onClicked: console.log("Fan mode") }
                    CircularIconButton { iconName: "local_fire_department"; onClicked: console.log("Heat mode") }
                    CircularIconButton { iconName: "severe_cold"; onClicked: console.log("Cool mode") }
                    CircularIconButton { iconName: "nest_eco_leaf"; onClicked: console.log("Eco mode") }

                    Item { Layout.fillWidth: true } // right spacer
                }
            }

            // -- Bottom Space --
            Item { Layout.fillHeight: true }
        }
    }
}
