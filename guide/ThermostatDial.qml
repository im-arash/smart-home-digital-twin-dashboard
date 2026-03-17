import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Shapes

Item {
    width: 300
    height: 500

    Rectangle {
        anchors.fill: parent
        radius: 20
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#707070" }
            GradientStop { position: 1.0; color: "#505050" }
        }

        ColumnLayout{
            anchors.fill: parent
            spacing: 15
            RowLayout{
                Layout.margins: 20
                Layout.fillWidth: true
                Text{
                    text: "Thermostat"
                    color: "white"
                    font.pixelSize: 16
                    font.bold: true
                }
                Rectangle{Layout.fillWidth: true}
                Switch{

                }
            }



            Dial {
                id: control
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                from: 10
                to: 35
                stepSize: 1
                value: 20
                Layout.preferredWidth: 250
                Layout.preferredHeight: 250

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

                        // Force high-quality antialiasing using multisampling
                        layer.enabled: true
                        layer.samples: 8

                        ShapePath {
                            fillColor: "transparent"
                            strokeColor: "deepskyblue"
                            strokeWidth: 15
                            // Change to ShapePath.RoundCap if you want the ends of the blue bar to be rounded
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
                                Translate {
                                    y: -parent.height / 2 + 25
                                },
                                Rotation {
                                    angle: -140 + (index / (tickRepeater.model - 1)) * 280
                                    origin.x: tick.width / 2
                                    origin.y: tick.height / 2
                                }
                            ]
                        }
                    }
                }

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

                handle: Rectangle {
                    id: handleItem
                    x: control.background.x + control.background.width / 2 - width / 2
                    y: control.background.y + control.background.height / 2 - height / 2
                    width: 30
                    height: 30
                    color: control.pressed ? "dodgerblue" : "LightBlue"
                    radius: 30
                    antialiasing: true
                    opacity: control.enabled ? 1 : 0.3
                    transform: [
                        Translate {
                            y: -Math.min(control.background.width, control.background.height) * 0.47
                        },
                        Rotation {
                            angle: control.angle
                            origin.x: handleItem.width / 2
                            origin.y: handleItem.height / 2
                        }
                    ]

                    Rectangle {
                        anchors.centerIn: parent
                        width: 15
                        height: 15
                        radius: 15
                        color: "#909090"
                    }
                }
            }

            //-- increase decrease buttons--
            RowLayout{
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                spacing: 20
                Rectangle{
                    width: 36
                    height: 36
                    radius: 36
                    color: "gray"
                    MaterialIcon {
                        anchors.centerIn: parent
                        icon: "check_indeterminate_small"
                    }
                }

                Rectangle{
                    width: 36
                    height: 36
                    radius: 36
                    color: "gray"
                    MaterialIcon {
                        anchors.centerIn: parent
                        icon: "add"
                    }
                }
            }

            //--Action Buttons--
            ColumnLayout{
                Text{text: "Actions"; color: "white";Layout.leftMargin: 20}
                Layout.fillWidth: true
                spacing: 10
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 15

                    Item { Layout.fillWidth: true }   // left spacer

                    Rectangle {
                        width: 50; height: 50; radius: 50; color: "gray"
                        MaterialIcon { anchors.centerIn: parent; icon: "mode_fan" }
                    }
                    Rectangle {
                        width: 50; height: 50; radius: 50; color: "gray"
                        MaterialIcon { anchors.centerIn: parent; icon: "local_fire_department" }
                    }
                    Rectangle {
                        width: 50; height: 50; radius: 50; color: "gray"
                        MaterialIcon { anchors.centerIn: parent; icon: "severe_cold" }
                    }
                    Rectangle {
                        width: 50; height: 50; radius: 50; color: "gray"
                        MaterialIcon { anchors.centerIn: parent; icon: "nest_eco_leaf" }
                    }

                    Item { Layout.fillWidth: true }   // right spacer
                }

            }
            //-- Bottom Space--
            Rectangle{Layout.fillHeight: true}

        }


    }
}
