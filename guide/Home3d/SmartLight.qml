import QtQuick
import QtQuick3D

PointLight {
    id: rootLight

    // Expose these so we can set them from the outside
    property string deviceId: ""
    property bool isOn: false
    property int powerDraw: 50

    // The light automatically follows the isOn property
    visible: isOn

    // Default light settings (you can override these later)
    brightness: 1.0

    // Self-registration logic
    Component.onCompleted: {
        if (deviceId !== "") {
            DeviceReceiver.registerDevice(rootLight)
        }
    }

    Component.onDestruction: {
        if (deviceId !== "") {
            DeviceReceiver.unregisterDevice(deviceId)
        }
    }
}
