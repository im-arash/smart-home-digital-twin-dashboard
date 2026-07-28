import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    width: 300
    height: 110

    component CircularAvatar : Item {
        property url imageSource

        Layout.preferredWidth: 40
        Layout.preferredHeight: 40

        Image {
            id: avatarImg
            anchors.fill: parent
            source: imageSource
            fillMode: Image.PreserveAspectCrop
            visible: false // Hidden because OpacityMask handles the rendering
        }

        OpacityMask {
            anchors.fill: avatarImg
            source: avatarImg
            maskSource: Rectangle {
                width: avatarImg.width
                height: avatarImg.height
                radius: width / 2
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: 20
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#808080" }
            GradientStop { position: 1.0; color: "#707070" }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20

            // --- Header Row ---
            RowLayout {
                Text {
                    text: "Members"
                    color: "white"
                    font.bold: true
                    font.pixelSize: 16
                    Layout.bottomMargin: 10
                }

                // Invisible spacer
                Item { Layout.fillWidth: true }

                // Add Button
                Rectangle {
                    width: 30
                    height: 30
                    radius: 15 // width / 2 makes a perfect circle
                    color: "transparent"

                    MaterialIcon {
                        anchors.centerIn: parent
                        icon: "add"
                    }

                    HoverHandler { onHoveredChanged: parent.color = hovered ? "#606060" : "transparent" }
                    TapHandler { onTapped: console.log("clicked add member") }
                }
            }

            // --- Avatars Row ---
            RowLayout {
                spacing: -10

                CircularAvatar { imageSource: "../images/members/father.webp" }
                CircularAvatar { imageSource: "../images/members/mom.webp" }
                CircularAvatar { imageSource: "../images/members/son.webp" }
            }
        }
    }
}
