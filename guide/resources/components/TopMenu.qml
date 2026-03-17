import QtQuick
import QtQuick.Layouts

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
    Rectangle {
        Layout.preferredWidth: 40
        Layout.preferredHeight: 40
        radius: 40
        color: "white"
    }
}
