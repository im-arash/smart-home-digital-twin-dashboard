import guide
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ApplicationWindow {
    width: 1280
    height: 720
    visible: true
    title: qsTr("")
    x: 500
    y: 100

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    Rectangle{
        anchors.fill: parent
        color: "#505050"

        Row{
            anchors.fill: parent
            spacing: 20
            MainMenu{

            }

            Rectangle{
                border.color: "gray"
                width: 300
                height: 500
                radius: 20
                gradient: Gradient {
                         GradientStop { position: 0.0; color: "#909090" }
                         GradientStop { position: 1.0; color: "#707070" }
                }
                Dial{
                    id: control
                    anchors.centerIn: parent
                    from: 0
                    to: 100
                    value: 50
                    width: 200
                    height: 200
                    Text {
                        id: temp
                        text: control.value.toFixed(0)
                        color: "white"
                        anchors.centerIn: parent
                    }
                    handle: Rectangle {
                        id: handleItem
                        x: control.background.x + control.background.width / 2 - width / 2
                        y: control.background.y + control.background.height / 2 - height / 2
                        width: 16
                        height: 16
                        color: control.pressed ? "dodgerblue" : "deepskyblue"
                        radius: 8
                        antialiasing: true
                        opacity: control.enabled ? 1 : 0.3
                        transform: [
                            Translate {
                                y: -Math.min(control.background.width, control.background.height) * 0.4 + handleItem.height / 2
                            },
                            Rotation {
                                angle: control.angle
                                origin.x: handleItem.width / 2
                                origin.y: handleItem.height / 2
                            }
                        ]
                    }
                }
            }


        }
    }


}
