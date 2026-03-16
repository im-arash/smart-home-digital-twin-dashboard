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
        color: "#505050"

        Row{
            anchors.fill: parent
            anchors.margins: 10
            spacing: 20

            MainMenu{}

            ThermostatDial{}


        }
    }


}
