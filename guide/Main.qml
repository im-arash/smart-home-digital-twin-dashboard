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
    title: qsTr("")

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

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
                        WeatherWidget {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }

                        //-- Locks --
                        RowLayout {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: Style.space

                            Rectangle {
                                Layout.fillWidth: true
                                // 1. Force equal 50/50 weighting ratio
                                Layout.preferredWidth: 1
                                Layout.fillHeight: true
                                radius: 20
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: "#808080" }
                                    GradientStop { position: 1.0; color: "#606060" }
                                }
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                // 2. Force equal 50/50 weighting ratio
                                Layout.preferredWidth: 1
                                Layout.fillHeight: true
                                radius: 20
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: "#808080" }
                                    GradientStop { position: 1.0; color: "#606060" }
                                }
                            }
                        }

                        //-- Energy --
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            radius: 20
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "#606060" }
                                GradientStop { position: 1.0; color: "#505050" }
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        radius: 20
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "#808080" }
                            GradientStop { position: 1.0; color: "#505050" }
                        }
                    }

                }
            }

            // Rectangle { Layout.fillWidth: true }
        }
    }
}
