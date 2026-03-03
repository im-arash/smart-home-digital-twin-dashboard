import QtQuick
import QtQuick.Layouts

Item{
    width: 80
    height: parent.height
    Rectangle{
        anchors.fill: parent
        radius: 20
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#909090" }
            GradientStop { position: 1.0; color: "#707070" }
        }
        ColumnLayout{
            spacing: 20
            anchors.fill: parent
            Rectangle{
                Layout.topMargin: 20
                color: "white"
                height: 40
                width: 40
                radius: 10
                Layout.alignment: Qt.AlignHCenter
            }

            Rectangle{
                color: "white"
                height: 40
                width: 40
                radius: 10
                Layout.alignment: Qt.AlignHCenter
            }

            Rectangle{
                color: "white"
                height: 40
                width: 40
                radius: 10
                Layout.alignment: Qt.AlignHCenter
            }
            //--- Space ---
            Rectangle{
                Layout.fillHeight: true
            }

            Rectangle{
                Layout.bottomMargin: 20
                color: "white"
                height: 40
                width: 40
                radius: 10
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            }
        }
    }
}
