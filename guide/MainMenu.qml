import QtQuick
import QtQuick.Layouts

Item{
    width: 70
    height: parent.height
    Rectangle{
        anchors.fill: parent
        radius: 20
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#909090" }
            GradientStop { position: 1.0; color: "#707070" }
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

                HoverHandler {onHoveredChanged: parent.color = hovered ? "gray" : "transparent"}
                TapHandler { onTapped: console.log("clicked home_app_logo") }
            }

            Rectangle{
                color: "transparent"
                height: 40
                width: 40
                radius: 10
                Layout.alignment: Qt.AlignHCenter

                MaterialIcon {icon: "search"}

                HoverHandler {onHoveredChanged: parent.color = hovered ? "gray" : "transparent"}
                TapHandler { onTapped: console.log("clicked home_app_logo") }
            }

            Rectangle{
                color: "transparent"
                height: 40
                width: 40
                radius: 10
                Layout.alignment: Qt.AlignHCenter

                MaterialIcon {icon: "apps"}

                HoverHandler {onHoveredChanged: parent.color = hovered ? "gray" : "transparent"}
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

                HoverHandler {onHoveredChanged: parent.color = hovered ? "gray" : "transparent"}
                TapHandler { onTapped: console.log("clicked home_app_logo") }
            }
        }
    }
}
