import QtQuick

Rectangle {
    id: root
    z: 100
    anchors.fill: parent

    // We need these properties to track the thermostat
    property string mode: "off"
    // CHANGE 1: Use roomTemperature instead of temperature
    property real roomTemperature: 24.0

    // Set how strong the color gets at maximum (e.g., 0.2 = 20% opacity)
    property real maxOpacity: 0.15

    // Ignore touches on the overlay
    enabled: false

    color: {
        // No tint if turned off
        if (mode === "off") {
            return "transparent"
        }

        // CHANGE 2: Calculate based on roomTemperature
        // Cold Zone (Below 20)
        if (roomTemperature < 20) {
            let intensity = (20 - roomTemperature) / 10.0
            return Qt.rgba(0.0, 0.4, 1.0, intensity * maxOpacity) // Deep Blue
        }
        // Hot Zone (Above 25)
        else if (roomTemperature > 25) {
            let intensity = (roomTemperature - 25) / 10.0
            return Qt.rgba(1.0, 0.0, 0.0, intensity * maxOpacity) // Red
        }
        // Comfort Zone (20 to 25)
        else {
            return "transparent"
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: 1000
            easing.type: Easing.InOutQuad
        }
    }
}
