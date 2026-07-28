import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

RowLayout {
    Layout.leftMargin: 20
    Layout.fillWidth: true

    // 1. Left side: Rooms text
    RowLayout {
        spacing: 60
        Text { text: "Living Room"; color: "white"; font.bold: true; font.pixelSize: 20 }
        Text { text: "Bed Room"; color: "#909090"; font.bold: true; font.pixelSize: 20 }
        Text { text: "Kitchen"; color: "#909090"; font.bold: true; font.pixelSize: 20 }
        Text { text: "Bathroom"; color: "#909090"; font.bold: true; font.pixelSize: 20 }
    }

    // 2. The Spacer: Absorbs all extra horizontal space
    Item {
        Layout.fillWidth: true
    }

    // 3. Right side: Profile/Icon Circle
    RowLayout{
        spacing: Style.space
        Rectangle {
            color: "#505050"
            Layout.preferredWidth: Style.mainIconSize
            Layout.preferredHeight: Style.mainIconSize
            radius: 40
            MaterialIcon {
                anchors.centerIn: parent
                icon: "apps"
                size: 20
            }
        }

        Rectangle {
            color: "#505050"
            Layout.preferredWidth: Style.mainIconSize
            Layout.preferredHeight: Style.mainIconSize
            radius: 40
            MaterialIcon {
                anchors.centerIn: parent
                icon: "notifications"
                size: 20
            }
        }


        Item {
            Layout.preferredWidth: Style.mainIconSize
            Layout.preferredHeight: Style.mainIconSize

            Image {
                id: avatarImg
                anchors.fill: parent
                source: "../images/members/father.webp"
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
    }


}
