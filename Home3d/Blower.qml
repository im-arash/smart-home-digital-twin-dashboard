import QtQuick
import QtQuick3D
import QtQuick3D.Particles3D

Node {
    id: livingRoomThermostat

        // --- C++ Controlled Properties (User Settings) ---
        property string deviceId: "LR-TH-01"
        property string mode: "off"      // Client sets this: "auto", "heat", "cool", "eco", "off"
        property real temperature: 20.0   // TARGET temperature

        // --- Internal Machine State (Hardware Action) ---
        property string activeState: "off" // "heat", "cool", "eco", "off" - Drives the 3D visual/power
        property real roomTemperature: 24.0 // Current simulated room temp
        property real ambientTemperature: 24.0 // Natural house temp

        // Power Draw now depends on what the hardware is ACTUALLY doing
        property int powerDraw: activeState === "off" ? 0 : (activeState === "eco" ? 100 : 1500)

        Component.onCompleted: DeviceReceiver.registerDevice(livingRoomThermostat)

        onTemperatureChanged: evaluateMode()
        onModeChanged: evaluateMode()

        // --- The Brain (Separates User Choice from Hardware Action) ---
        function evaluateMode() {
            if (mode === "off") {
                activeState = "off";
                return;
            }

            // 1. Manual Overrides (Forced Modes)
            if (mode === "heat") {
                activeState = "heat";
            } else if (mode === "cool") {
                activeState = "cool";
            } else if (mode === "eco") {
                activeState = "eco";
            }
            // 2. Automatic Mode (Smart Switching with Hysteresis)
            else if (mode === "auto") {
                if (activeState === "cool") {
                    if (roomTemperature <= temperature) activeState = "eco";
                } else if (activeState === "heat") {
                    if (roomTemperature >= temperature) activeState = "eco";
                } else {
                    // Currently in "eco" or "off", wait for 1.0 degree drift
                    if (roomTemperature > temperature + 1.0) {
                        activeState = "cool";
                    } else if (roomTemperature < temperature - 1.0) {
                        activeState = "heat";
                    } else {
                        activeState = "eco";
                    }
                }
            }
        }

        // --- Particle Logic (Now reacts to activeState, not mode) ---
        onActiveStateChanged: {
            if (activeState === "cool") {
                windParticle.color = Qt.rgba(0.0, 0.4, 0.8, 0.01)
                windEmitter.emitRate = 400
            } else if (activeState === "heat") {
                windParticle.color = Qt.rgba(0.9, 0.4, 0.4, 0.01)
                windEmitter.emitRate = 400
            } else if (activeState === "eco") {
                windParticle.color = Qt.rgba(0.0, 0.8, 0.2, 0.004)
                windEmitter.emitRate = 150
            } else {
                windEmitter.emitRate = 0
            }
        }

        // --- The Simulation Loop ---
        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                // Apply temperature changes (with safety limits so it doesn't heat to infinity if forced!)
                if (activeState === "heat" && roomTemperature < 35.0) {
                    roomTemperature += 0.5;
                } else if (activeState === "cool" && roomTemperature > 10.0) {
                    roomTemperature -= 0.5;
                } else if (activeState === "eco" || activeState === "off") {
                    // Drift back to ambient
                    if (roomTemperature < ambientTemperature - 0.1) roomTemperature += 0.1;
                    if (roomTemperature > ambientTemperature + 0.1) roomTemperature -= 0.1;
                }

                evaluateMode(); // Constantly check if we need to switch
            }
        }

    // --- Existing 3D Setup ---
    ParticleSystem3D {
        id: windSystem
        x: -18.942
        y: 2.322
        z: 2.205
    }

    SpriteParticle3D {
        id: windParticle
        maxAmount: 10000
        particleScale: 0.5
        color: "transparent"
        billboard: true
        fadeInDuration: 0
        fadeOutDuration: 100
    }

    ParticleEmitter3D {
        id: windEmitter
        system: windSystem
        particle: windParticle
        emitRate: 0
        lifeSpan: 50000

        velocity: VectorDirection3D {
            direction: Qt.vector3d(-0.1, -0.5, 0)
            directionVariation: Qt.vector3d(2, 0, 2)
        }
    }
}
