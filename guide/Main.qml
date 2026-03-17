import guide
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ApplicationWindow {
    width: 1280
    height: 720
    visible: true
    title: qsTr("")
    x: 500
    y: 100

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    FontLoader {
        id: materialIcons
        source: "MaterialSymbolsSharp.ttf"
    }


    Rectangle{
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#606060" }
            GradientStop { position: 1.0; color: "#404040" }
        }

        RowLayout{
            anchors.fill: parent
            spacing: 15
            anchors.margins: 15

            MainMenu{}

            ColumnLayout{
                Rectangle{Layout.fillHeight: true}
                spacing: 15

                MembersWidget{}

                ThermostatDial{}


            }



            Rectangle{Layout.fillWidth: true}

        }
    }


}
