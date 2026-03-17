import QtQuick

Item {
    property string icon
    property int size: 28
    property color iconColor: "white"

    implicitWidth: size
    implicitHeight: size

    anchors.centerIn: parent
    Text {
        anchors.centerIn: parent
        text: icon
        font.family: materialIcons.name
        font.pixelSize: size
        color: iconColor
    }
}


// import QtQuick
// import QtQuick.Layouts
// import QtQuick.Effects // Replaced Qt5Compat.GraphicalEffects

// Rectangle {
//     Layout.fillWidth: true
//     Layout.preferredWidth: 1
//     Layout.fillHeight: true
//     radius: 20
//     gradient: Gradient {
//         GradientStop { position: 0.0; color: "#808080" }
//         GradientStop { position: 1.0; color: "#606060" }
//     }

//     // Modern Qt 6 rounded image mask
//     Image {
//         id: avatarImg
//         anchors.fill: parent
//         source: "../images/lock.png"
//         fillMode: Image.PreserveAspectCrop

//         layer.enabled: true
//         layer.effect: MultiEffect {
//             maskEnabled: true
//             maskSource: Rectangle {
//                 width: avatarImg.width
//                 height: avatarImg.height
//                 radius: 20
//                 visible: false // Source acts as a cookie-cutter
//             }
//         }
//     }

//     ColumnLayout {
//         anchors.fill: parent
//         anchors.margins: 20

//         Text {
//             text: "Closed"
//             color: "white"
//         }

//         Text {
//             Layout.preferredWidth: 40
//             text: "Front Door"
//             color: "white"
//             font.pixelSize: 16
//             font.bold: true
//             wrapMode: Text.WordWrap
//         }

//         Item { Layout.fillHeight: true }

//         //--Lock Switch--
//         Rectangle {
//             Layout.preferredWidth: 120
//             Layout.preferredHeight: 40
//             radius: 40
//             color: "#909090"

//             RowLayout {
//                 anchors.fill: parent
//                 anchors.margins: 2

//                 Rectangle { // left
//                     Layout.preferredWidth: 34
//                     Layout.preferredHeight: 34
//                     radius: 40
//                     color: "white"
//                     MaterialIcon {
//                         anchors.centerIn: parent
//                         icon: "lock_outline"
//                         size: 18
//                         iconColor: "#606060"
//                     }
//                 }

//                 //--spacer--
//                 Item {
//                     Layout.fillWidth: true

//                     // FIX: Anchor this inner layout to the center of the Item
//                     RowLayout {
//                         anchors.centerIn: parent
//                         spacing: -8 // Optional: pull chevrons closer together

//                         Text {
//                             text: "chevron_forward"
//                             font.family: materialIcons.name
//                             font.pixelSize: 24
//                             color: "white"
//                             opacity: 0.2
//                         }
//                         Text {
//                             text: "chevron_forward"
//                             font.family: materialIcons.name
//                             font.pixelSize: 24
//                             color: "white"
//                             opacity: 0.5
//                         }
//                         Text {
//                             text: "chevron_forward"
//                             font.family: materialIcons.name
//                             font.pixelSize: 24
//                             color: "white"
//                             opacity: 0.8
//                         }
//                     }
//                 }

//                 Rectangle { // right
//                     Layout.preferredWidth: 34
//                     Layout.preferredHeight: 34
//                     radius: 40
//                     // FIX: Corrected the invalid "#990990990" color
//                     color: "transparent"
//                     MaterialIcon {
//                         anchors.centerIn: parent
//                         icon: "lock_open_right"
//                         size: 18
//                     }
//                 }
//             }
//         }
//     }
// }
