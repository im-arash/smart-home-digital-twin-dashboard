import QtQuick
import QtQuick.Layouts

Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    radius: 20
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#606060" }
        GradientStop { position: 1.0; color: "#505050" }
    }
}
