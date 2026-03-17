import QtQuick

Item {
    Rectangle {
        anchors.fill: parent
        radius: 20
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#808080" }
            GradientStop { position: 1.0; color: "#707070" }
        }
    }
}
