import QtQuick
import QtQuick3D
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import "exterior"
import "interior"
import QtQuick3D.Particles3D

Item {
    id: sceneRoot
    width: 640
    height: 480


    ColumnLayout{
        z:100
        Text {
            text: "Energy Used: " + DeviceReceiver.totalEnergyUsage.toFixed(2) + " Wh"
            color: "white"
            font.pixelSize: 16
        }

        Text {
            // Shows everything cleanly!
            text: "Room: " + livingRoomThermostat.roomTemperature.toFixed(1) + "°C  |  Target: " + livingRoomThermostat.temperature.toFixed(1) + "°C\n" +
                  "Setting: " + livingRoomThermostat.mode.toUpperCase() + "  |  System: " + livingRoomThermostat.activeState.toUpperCase()

            color: {
                if (livingRoomThermostat.roomTemperature < 20) return "#4aa5ff"
                if (livingRoomThermostat.roomTemperature > 25) return "#ff4a4a"
                // if (livingRoomThermostat.roomTemperature === "eco") return "#4aff71"
                return "#4aff71"
            }
            font.pixelSize: 16
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
        }
    }



    ThermostatTintOverlay {
        roomTemperature: livingRoomThermostat.roomTemperature
        mode: livingRoomThermostat.activeState // <-- Change this to activeState!
    }

    // Expose these to Main.qml
    property alias sceneEnvironment: sceneEnvironment
    property alias sceneCamera: sceneCamera
    property alias interiorCamera1: interiorCamera1
    property alias sharedScene: sharedSceneNode
    property alias exteriorLoader: exteriorLoader
    property alias thermostat: livingRoomThermostat

    SceneEnvironment {
        id: sceneEnvironment
        antialiasingMode: (exteriorLoader.item
                           !== null) ? SceneEnvironment.MSAA : SceneEnvironment.NoAA
        antialiasingQuality: SceneEnvironment.High
    }

    Node {
        id: sharedSceneNode

        SmartLight {
            id: livingRoomLight
            deviceId: "LR-L-01"
            x: -244.97
            y: 1.724
            z: 8.93887
            brightness: 1.0

            onIsOnChanged: {
                if (interiorLoader.item && interiorLoader.item.ceilingLightMaterial) {
                    interiorLoader.item.ceilingLightMaterial.emissiveFactor =
                        isOn ? Qt.vector3d(6,6,6) : Qt.vector3d(0,0,0)
                }
            }
        }



        Blower {
            id: livingRoomThermostat
            x: -219.457
            y: 0
            z: 7
        }


        Node {
            id: exteriorRoot
            Loader3D {
                id: exteriorLoader
                x: -16.374
                y: -2.915
                z: -51.96756
                asynchronous: true
                // Load the file directly instead of using sourceComponent
                source: "exterior/Exterior.qml"

                onLoaded: interiorLoader.active = true
            }
        }

        Node {
            id: interiorRoot
            Loader3D {
                id: interiorLoader
                x: -239.987
                y: 0
                z: 6.39146
                asynchronous: true
                active: false
                // Load the file directly instead of using sourceComponent
                source: "interior/Interior.qml"
            }
        }

        Node {
            id: scene
            DirectionalLight {
                id: directionalLight
                x: -31.882
                y: 48.324
                z: 150.25191
                brightness: 2.7
                eulerRotation.x: -30
                eulerRotation.y: 45
            }
        }

        PerspectiveCamera {
            id: sceneCamera
            x: -84.981
            y: 0.614
            eulerRotation.z: 0
            z: 14.15921
            clipNear: 2
            eulerRotation.y: -40.5
            eulerRotation.x: 8
        }

        PerspectiveCamera {
            id: interiorCamera1
            x: -243.993
            y: 2.418
            z: 2.92897
            fieldOfView: 53
            clipFar: 400
            clipNear: 1
            eulerRotation.y: -154.5
            eulerRotation.x: -16
        }

        Model {
            id: sphere
            x: -89.379
            y: 6.458
            z: -0.55852
            source: "#Sphere"
            eulerRotation.z: 9.80961
            eulerRotation.y: 117.86542
            eulerRotation.x: -20.13272
            castsShadows: false
            receivesShadows: false
            castsReflections: false
            scale: Qt.vector3d(2.10938, 2.10938, 2.10938)

            materials: PrincipledMaterial {
                cullMode: PrincipledMaterial.NoCulling
                lighting: PrincipledMaterial.NoLighting

                baseColorMap: Texture {
                    source: "day1.webp"
                    minFilter: Texture.None
                    generateMipmaps: false
                    autoOrientation: false
                }
            }

            NumberAnimation on eulerRotation.y {
                from: 0
                to: 360
                duration: 600000
                loops: Animation.Infinite
            }
        }

        Node {
            id: lights
            x: 2
            y: 0.8
            z: 4.05
            visible: false
            PointLight {
                x: -84.524
                brightness: 4.04
                linearFade: 10
                constantFade: 1
                scope: exteriorRoot
            }
            PointLight {
                x: -78.078
                brightness: 4.04
                linearFade: 10
                constantFade: 1
                scope: exteriorRoot
            }
            PointLight {
                x: -69.238
                brightness: 4.04
                linearFade: 10
                constantFade: 1
                scope: exteriorRoot
            }
        }



        Model {
            id: cube
            x: -238.8
            y: 2.301
            source: "#Cube"
            scale.z: 0.02042
            scale.y: 0.00419
            scale.x: 0.00495
            z: 9.0472
            // materials: [
            //     DefaultMaterial {
            //         diffuseColor: "white"
            //     }
            // ]
            materials: PrincipledMaterial {
                cullMode: PrincipledMaterial.NoCulling
                lighting: PrincipledMaterial.FragmentLighting

                baseColorMap: Texture {
                    source: "gplus.webp"
                    minFilter: Texture.None
                    generateMipmaps: true
                    autoOrientation: false
                }
            }
        }
    }

    // 3. Main UI View3D
    View3D {
        id: view3D
        anchors.fill: parent
        environment: sceneEnvironment
        camera: sceneCamera
        importScene: sharedSceneNode
    }

    RowLayout {
        anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        Button {
            text: "lights"
            onClicked: lights.visible = !lights.visible
        }
        Button {
            text: "camera"
            onClicked: view3D.camera = view3D.camera
                       === interiorCamera1 ? sceneCamera : interiorCamera1
        }
    }

    Item {
        id: __materialLibrary__

        PrincipledMaterial {
            objectName: ""
            cullMode: PrincipledMaterial.NoCulling
            lighting: PrincipledMaterial.NoLighting
        }

        Texture {
            source: "day1.webp"
            objectName: ""
            minFilter: Texture.None
            generateMipmaps: false
            autoOrientation: false
        }

        PrincipledMaterial {
            objectName: ""
            cullMode: PrincipledMaterial.NoCulling
            lighting: PrincipledMaterial.FragmentLighting
        }

        Texture {
            source: "gplus.webp"
            objectName: ""
            minFilter: Texture.None
            generateMipmaps: true
            autoOrientation: false
        }
    }
}

/*##^##
Designer {
    D{i:0}D{i:3;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
}
##^##*/

