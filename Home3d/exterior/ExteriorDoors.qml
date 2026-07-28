import QtQuick
import QtQuick3D

Node {
    id: staticNode

    // 1. ADDED: Unique ID matching the one used in the Client slider
    property string deviceId: "garage_door"

    // 2. Controlled by C++ DeviceReceiver when it gets WebSocket messages
    property bool isGarageLocked: true

    // 3. ADDED: Register this device to the C++ backend immediately when created
    Component.onCompleted: {
        // NOTE: Make sure 'DeviceReceiver' matches exactly how you access your C++ singleton!
        // If you registered it as a context property (e.g. 'deviceReceiver'), use lowercase.
        if (typeof DeviceReceiver !== "undefined") {
            DeviceReceiver.registerDevice(staticNode)
        } else if (typeof deviceReceiver !== "undefined") {
            deviceReceiver.registerDevice(staticNode)
        }
    }

    property url textureData134: "maps/textureData134.png"
    property url textureData136: "maps/textureData136.png"
    property url textureData142: "maps/textureData142.png"
    property url textureData144: "maps/textureData144.png"

    Node {
        id: nodes_49_
        objectName: "nodes[49]"

        // Split position into x, y, z so we can easily animate just 'y'
        x: -62.9535
        z: 55.8396

        // If locked, y is 1.6574. If unlocked, it moves UP by 200 units.
        y: staticNode.isGarageLocked ? 1.6574 : (1.6574 + 3.5)

        Behavior on y {
            NumberAnimation {
                duration: 7000 // 7 seconds
                easing.type: Easing.InOutQuad // Smooth start and stop
            }
        }

        rotation: Qt.quaternion(1, 2.18557e-08, 0, 0)
        Model {
            id: ae34_008_Garage_Door
            x: 0
            y: 0.028
            objectName: "AE34_008_Garage_Door"
            scale: Qt.vector3d(0.01, 0.01, 0.01)
            source: "meshes/ae34_008_Garage_Door_mesh.mesh"
            z: 0
            materials: [
                adskMatAE34_008_Garage_Door_material
            ]
        }
    }

    Node {
        id: nodes_51_
        objectName: "nodes[51]"
        position: Qt.vector3d(-49.6292, 1.58711, 55.7834)
        rotation: Qt.quaternion(0.707107, 1.54543e-08, -0.707107, 1.54543e-08)
        Model {
            id: ae34_008_House_Door
            objectName: "AE34_008_House_Door"
            scale: Qt.vector3d(0.01, 0.01, 0.01)
            source: "meshes/ae34_008_House_Door_mesh.mesh"
            materials: [
                adskMatAE34_008_House_Door_material
            ]
        }
    }

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: adskMatAE34_008_Garage_Door_material
            objectName: "adskMatAE34_008_Garage_Door"
            baseColor: "#ffbbbbbb"
            baseColorMap: _20_texture
            metalnessMap: _21_texture
            roughnessMap: _21_texture
            roughness: 1
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: adskMatAE34_008_House_Door_material
            objectName: "adskMatAE34_008_House_Door"
            baseColor: "#ffbbbbbb"
            baseColorMap: _22_texture
            metalnessMap: _23_texture
            roughnessMap: _23_texture
            roughness: 1
            alphaMode: PrincipledMaterial.Opaque
        }

        Texture {
            id: _20_texture
            source: staticNode.textureData134
            objectName: "_20_texture"
        }

        Texture {
            id: _21_texture
            source: staticNode.textureData136
            objectName: "_21_texture"
        }

        Texture {
            id: _22_texture
            source: staticNode.textureData142
            objectName: "_22_texture"
        }

        Texture {
            id: _23_texture
            source: staticNode.textureData144
            objectName: "_23_texture"
        }
    }
}

/*##^##
Designer {
    D{i:0;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
}
##^##*/
