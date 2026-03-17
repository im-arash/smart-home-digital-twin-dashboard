import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
Item {
    width: 300
    height: 110
    Rectangle {
        anchors.fill: parent
        radius: 20
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#808080" }
            GradientStop { position: 1.0; color: "#707070" }
        }
        ColumnLayout{
            anchors.fill: parent
            anchors.margins: 20
            RowLayout{
                Text{text: "Members"; color: "white"; font.bold: true; font.pixelSize: 16}
                Rectangle{Layout.fillWidth: true}
                Rectangle {
                    width: 30; height: 30; radius: 30; color: "transparent"
                    MaterialIcon { anchors.centerIn: parent; icon: "add" }
                }
            }

            RowLayout{
                spacing: -10
                Rectangle {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    color: "transparent"

                    Image {
                        id: avatar
                        anchors.fill: parent
                        source: "resources/images/members/father.webp"
                        fillMode: Image.PreserveAspectCrop
                        visible: false
                    }

                    OpacityMask {
                        anchors.fill: avatar
                        source: avatar
                        maskSource: Rectangle {
                            width: avatar.width
                            height: avatar.height
                            radius: width / 2
                        }
                    }
                }


                Rectangle {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    color: "transparent"

                    Image {
                        id: avatar1
                        anchors.fill: parent
                        source: "resources/images/members/mom.webp"
                        fillMode: Image.PreserveAspectCrop
                        visible: false
                    }

                    OpacityMask {
                        anchors.fill: avatar1
                        source: avatar1
                        maskSource: Rectangle {
                            width: avatar1.width
                            height: avatar1.height
                            radius: width / 2
                        }
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    color: "transparent"

                    Image {
                        id: avatar2
                        anchors.fill: parent
                        source: "resources/images/members/son.webp"
                        fillMode: Image.PreserveAspectCrop
                        visible: false
                    }

                    OpacityMask {
                        anchors.fill: avatar2
                        source: avatar2
                        maskSource: Rectangle {
                            width: avatar2.width
                            height: avatar2.height
                            radius: width / 2
                        }
                    }
                }
            }




        }
    }
}
