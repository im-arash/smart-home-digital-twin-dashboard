import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
    Layout.fillWidth: true
    Layout.preferredHeight: 170
    Rectangle {
        anchors.fill: parent
        radius: 20

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#808080" }
            GradientStop { position: 1.0; color: "#505050" }
        }

        ColumnLayout{
            Text{
                text: "Device Control"
                color: "white"
                font.bold: true
                font.pixelSize: 16
            }

            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 10
            anchors.topMargin: 20
            RowLayout {
                Layout.fillWidth: true
                Text {
                    text: "CCTV"
                    color: "white"
                    font.pixelSize: 14
                }

                Item { Layout.fillWidth: true } // spacer

                Switch {
                    id: cctvSwitch
                    checked: cctvVWidget.cctvEnabled // Keep UI synced

                    onCheckedChanged: {
                        cctvVWidget.cctvEnabled = checked
                    }
                }
            }


            RowLayout {
                Layout.fillWidth: true
                Text {
                    text: "Lights"
                    color: "white"
                    font.pixelSize: 14
                    // font.bold: true
                }

                Item { Layout.fillWidth: true } // spacer

                Switch {
                    id: lightSwitch
                    onToggled: {
                        deviceController.switchInteriorLight("LR-L-01")
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text {
                    text: "TV"
                    color: "white"
                    font.pixelSize: 14
                    // font.bold: true
                }

                Item { Layout.fillWidth: true } // spacer

                Switch {
                    id: tvSwitch
                }
            }

            Item { Layout.fillHeight: true } // spacer
        }
    }
}
