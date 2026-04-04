import guide
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ApplicationWindow {
    id: root
    width: 1280
    height: 720
    visible: true
    title: "Smart Home"

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    DeviceController{id: deviceController}

    FontLoader {
        id: materialIcons
        source: "resources/icons/MaterialSymbolsSharp.ttf"
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#606060" }
            GradientStop { position: 1.0; color: "#404040" }
        }

        RowLayout {
            anchors.fill: parent
            spacing: Style.space
            anchors.margins: Style.space

            MainMenu {}

            ColumnLayout {
                Layout.fillHeight: true

                //-- Rooms --
                Item { Layout.fillHeight: true }
                TopMenu {}
                Item { Layout.fillHeight: true }

                RowLayout {
                    spacing: Style.space

                    //--Members & Thermostat
                    ColumnLayout {
                        spacing: Style.space
                        Layout.alignment: Qt.AlignTop

                        MembersWidget {}

                        ThermostatDial {}
                    }

                    //--Weather & Lockes & Energy--
                    ColumnLayout {
                        Layout.alignment: Qt.AlignTop
                        spacing: Style.space

                        // Enforce a strict 450px width in all directions
                        Layout.preferredWidth: 450
                        Layout.minimumWidth: 450
                        Layout.maximumWidth: 450

                        //-- Weather --
                        WeatherWidget {}

                        //-- Locks --
                        RowLayout {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: Style.space
                            LockWidget {
                                lockName: "Front Door"
                                deviceId: "front_door"
                            }
                            LockWidget {
                                lockName: "Garage Door"
                                deviceId: "garage_door"

                            }
                        }


                        //-- Energy --
                        EnergyGraphWidget{}
                    }

                    ColumnLayout{
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        spacing: Style.space

                        //--CCTV--
                        CCTVWidget{
                            id: cctvVWidget
                        }

                        //--- Device Controller Widget ---
                        DeviceCTRLWidget{}

                    }



                }
            }

            // Rectangle { Layout.fillWidth: true }
        }
    }
}
