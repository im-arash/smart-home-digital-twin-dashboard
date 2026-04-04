import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Rectangle {
    id: root

    property string lockName: ""
    property string deviceId: ""
    property bool isLocked: true

    onIsLockedChanged: {
            // 2. USE root.deviceId INSTEAD OF "garage_door"
            if (typeof deviceController !== "undefined" && root.deviceId !== "") {
                deviceController.setDeviceState(root.deviceId, root.isLocked ? "locked" : "unlocked")
            }
        }


    Layout.fillWidth: true
    Layout.preferredWidth: 1
    Layout.preferredHeight: 190
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
            text: root.isLocked ? "Closed" : "Open"
            color: "white"
        }

        Text {
            id: lockLabel
            Layout.preferredWidth: 40
            text: root.lockName
            color: "white"
            font.pixelSize: 16
            font.bold: true
            wrapMode: Text.WordWrap
        }

        Item { Layout.fillHeight: true }

        // -- Custom Slide Switch --
        Rectangle {
            id: switchTrack
            Layout.preferredWidth: 120
            Layout.preferredHeight: 40
            radius: 40
            color: "#909090"

            Rectangle {
                width: 34
                height: 34
                radius: 40
                color: "#808080"
                anchors.right: parent.right
                anchors.rightMargin: 3
                anchors.verticalCenter: parent.verticalCenter

                MaterialIcon {
                    anchors.centerIn: parent
                    icon: "lock_open_right"
                    size: 18
                    iconColor: "white"
                }
            }

            Rectangle {
                width: 34
                height: 34
                radius: 40
                color: "#808080"
                anchors.left: parent.left
                anchors.leftMargin: 3
                anchors.verticalCenter: parent.verticalCenter
                opacity: root.isLocked ? 0 : 1

                MaterialIcon {
                    anchors.centerIn: parent
                    icon: "lock_outline"
                    size: 18
                    iconColor: "white"
                }

                Behavior on opacity { NumberAnimation { duration: 250 } }
            }

            RowLayout {
                id: chevronRow
                anchors.centerIn: parent
                spacing: -6

                Text { text: "chevron_forward"; font.family: materialIcons.name; font.pixelSize: 18; color: "white"; opacity: 0.2 }
                Text { text: "chevron_forward"; font.family: materialIcons.name; font.pixelSize: 18; color: "white"; opacity: 0.5 }
                Text { text: "chevron_forward"; font.family: materialIcons.name; font.pixelSize: 18; color: "white"; opacity: 0.8 }

                Behavior on rotation { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
            }

            // 4. The Draggable Thumb
            Rectangle {
                id: thumb
                width: 34
                height: 34
                radius: 40
                anchors.verticalCenter: parent.verticalCenter
                z: 2

                // Let the Binding manage the X position when NOT dragging
                Binding {
                    target: thumb
                    property: "x"
                    value: root.isLocked ? 3 : (switchTrack.width - thumb.width - 3)
                    when: !dragArea.drag.active
                }

                MaterialIcon {
                    id: thumbIcon
                    anchors.centerIn: parent
                    size: 18
                }

                MouseArea {
                    id: dragArea
                    anchors.fill: parent
                    drag.target: thumb
                    drag.axis: Drag.XAxis
                    drag.minimumX: 3
                    drag.maximumX: switchTrack.width - thumb.width - 3

                    onReleased: {
                        // Determine lock state based on drop position
                        if (thumb.x > (switchTrack.width / 2 - thumb.width / 2)) {
                            root.isLocked = false
                        } else {
                            root.isLocked = true
                        }
                    }
                }

                Behavior on x { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
                Behavior on color { ColorAnimation { duration: 250 } }
            }

            // --- State Machine ---
            // Notice `x` is no longer in PropertyChanges. The Binding handles it.
            states: [
                State {
                    name: "locked"
                    when: root.isLocked
                    PropertyChanges { target: thumb; color: "white" }
                    PropertyChanges { target: thumbIcon; icon: "lock_outline"; iconColor: "#606060" }
                    PropertyChanges { target: chevronRow; rotation: 0 }
                },
                State {
                    name: "unlocked"
                    when: !root.isLocked
                    PropertyChanges { target: thumb; color: "dodgerblue" }
                    PropertyChanges { target: thumbIcon; icon: "lock_open_right"; iconColor: "white" }
                    PropertyChanges { target: chevronRow; rotation: 180 }
                }
            ]
        }
    }
}
