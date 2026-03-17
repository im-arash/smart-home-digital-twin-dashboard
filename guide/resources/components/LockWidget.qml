import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Rectangle {
    id: root // Give the root an ID to reference its properties

    // --- EXPOSE PROPERTY HERE ---
    property string lockName: "Front Door" // Default value
    // ----------------------------

    Layout.fillWidth: true
    Layout.preferredWidth: 1
    Layout.fillHeight: true
    radius: 20
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#808080" }
        GradientStop { position: 1.0; color: "#606060" }
    }

    Image {
        id: avatarImg
        anchors.fill: parent
        source: "../images/lock.png"
        fillMode: Image.PreserveAspectCrop
        visible: false
    }

    OpacityMask {
        anchors.fill: avatarImg
        source: avatarImg
        maskSource: Rectangle {
            width: avatarImg.width
            height: avatarImg.height
            radius: 20
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20

        Text {
            text: "Closed"
            color: "white"
        }

        Text {
            id: lockLabel
            Layout.preferredWidth: 40

            // --- BIND TO THE EXPOSED PROPERTY ---
            text: root.lockName
            // ------------------------------------

            color: "white"
            font.pixelSize: 16
            font.bold: true
            wrapMode: Text.WordWrap
        }

        Item { Layout.fillHeight: true }

        //--Lock Switch--
        Rectangle {
            Layout.preferredWidth: 120
            Layout.preferredHeight: 40
            radius: 40
            color: "#909090"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 2

                Rectangle { // left
                    Layout.preferredWidth: 34
                    Layout.preferredHeight: 34
                    radius: 40
                    color: "white"
                    MaterialIcon {
                        anchors.centerIn: parent
                        icon: "lock_outline"
                        size: 18
                        iconColor: "#606060"
                    }
                }

                //--spacer--
                Item {
                    Layout.fillWidth: true

                    RowLayout {
                        anchors.centerIn: parent
                        spacing: -6

                        Text {
                            text: "chevron_forward"
                            font.family: materialIcons.name
                            font.pixelSize: 18
                            color: "white"
                            opacity: 0.2
                        }
                        Text {
                            text: "chevron_forward"
                            font.family: materialIcons.name
                            font.pixelSize: 18
                            color: "white"
                            opacity: 0.5
                        }
                        Text {
                            text: "chevron_forward"
                            font.family: materialIcons.name
                            font.pixelSize: 18
                            color: "white"
                            opacity: 0.8
                        }
                    }
                }

                Rectangle { // right
                    Layout.preferredWidth: 34
                    Layout.preferredHeight: 34
                    radius: 40
                    color: "transparent" // Fixed invalid 9-digit hex color
                    MaterialIcon {
                        anchors.centerIn: parent
                        icon: "lock_open_right"
                        size: 18
                    }
                }
            }
        }
    }
}
