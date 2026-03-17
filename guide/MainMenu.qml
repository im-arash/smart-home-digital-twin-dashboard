import QtQuick
import QtQuick.Layouts
import QtQuick.Layouts

Item{
    Layout.preferredWidth: 78
    Layout.fillHeight: true
    Rectangle{
        anchors.fill: parent
        radius: 20
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#808080" }
            GradientStop { position: 1.0; color: "#505050" }
        }
        ColumnLayout{
            spacing: 20
            anchors.fill: parent
            Rectangle {
                Layout.topMargin: 20
                height: 40; width: 40; radius: 10
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"

                MaterialIcon {
                    anchors.centerIn: parent
                    icon: "home_app_logo"
                }

                HoverHandler {onHoveredChanged: parent.color = hovered ? "#606060" : "transparent"}
                TapHandler { onTapped: console.log("clicked home_app_logo") }
            }

            Rectangle{
                color: "transparent"
                height: 40
                width: 40
                radius: 10
                Layout.alignment: Qt.AlignHCenter

                MaterialIcon {icon: "search"}

                HoverHandler {onHoveredChanged: parent.color = hovered ? "#606060" : "transparent"}
                TapHandler { onTapped: console.log("clicked home_app_logo") }
            }

            Rectangle{
                color: "transparent"
                height: 40
                width: 40
                radius: 10
                Layout.alignment: Qt.AlignHCenter

                MaterialIcon {icon: "apps"}

                HoverHandler {onHoveredChanged: parent.color = hovered ? "#606060" : "transparent"}
                TapHandler { onTapped: console.log("clicked home_app_logo") }
            }

            //--- Space ---
            Rectangle{
                Layout.fillHeight: true
            }

            Rectangle{
                Layout.bottomMargin: 20
                color: "transparent"
                height: 40
                width: 40
                radius: 10
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

                MaterialIcon {icon: "power_settings_new"}

                HoverHandler {onHoveredChanged: parent.color = hovered ? "#606060" : "transparent"}
                TapHandler { onTapped: console.log("clicked home_app_logo") }
            }
        }
    }
}
