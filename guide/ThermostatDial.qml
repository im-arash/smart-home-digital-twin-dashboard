import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
    width: 300
    height: 500
    Rectangle{
        border.color: "gray"
        anchors.fill: parent
        radius: 20
        gradient: Gradient {
                 GradientStop { position: 0.0; color: "#909090" }
                 GradientStop { position: 1.0; color: "#707070" }
        }
        Dial{
            id: control
            anchors.centerIn: parent
            from: 10
            to: 35
            value: 20
            width: 250
            height: 250
            background: Rectangle {
                width: 250
                height: 250
                radius: 250
                color: "transparent"
                border.width: 15
                border.color: "#909090"
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
                color: control.pressed ? "dodgerblue" : "deepskyblue"
                radius: 30
                antialiasing: true
                opacity: control.enabled ? 1 : 0.3
                transform: [
                    Translate {
                        y: -Math.min(control.background.width, control.background.height) * 0.47 /*+ handleItem.height / 2*/
                    },
                    Rotation {
                        angle: control.angle
                        origin.x: handleItem.width / 2
                        origin.y: handleItem.height / 2
                    }
                ]
                Rectangle{
                    anchors.centerIn: parent
                    width: 15
                    height: 15
                    radius: 15
                    color: "#909090"
                }
            }
        }
    }
}
