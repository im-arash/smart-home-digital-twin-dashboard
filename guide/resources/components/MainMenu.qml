import QtQuick
import QtQuick.Layouts

Item {
    Layout.preferredWidth: 78
    Layout.fillHeight: true

    component MenuButton : Rectangle {
        property string iconName
        signal clicked()

        height: Style.mainIconSize
        width: Style.mainIconSize
        radius: 10
        Layout.alignment: Qt.AlignHCenter
        color: "transparent"

        MaterialIcon {
            anchors.centerIn: parent
            icon: iconName
        }

        HoverHandler {
            onHoveredChanged: parent.color = hovered ? "#606060" : "transparent"
        }

        TapHandler {
            onTapped: parent.clicked()
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: 20
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#808080" }
            GradientStop { position: 1.0; color: "#505050" }
        }

        ColumnLayout {
            spacing: Style.space
            anchors.fill: parent

            MenuButton {
                Layout.topMargin: Style.space
                iconName: "home_app_logo"
                onClicked: console.log("clicked home_app_logo")
            }

            MenuButton {
                iconName: "search"
                onClicked: console.log("clicked search")
            }

            MenuButton {
                iconName: "apps"
                onClicked: console.log("clicked apps")
            }

            //--- Space ---
            Item {
                Layout.fillHeight: true
            }

            MenuButton {
                Layout.bottomMargin: Style.space
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                iconName: "power_settings_new"
                onClicked: console.log("clicked power_settings_new")
            }
        }
    }
}
