import QtQuick
import Quickshell
import Quickshell.Bluetooth


Item {
    id: bluetoothDisplay
    property var shell
    // property bool bluetoothOn: true
    property bool bluetoothOn: Bluetooth.defaultAdapter
    ? Bluetooth.defaultAdapter.enabled
    : false
    // property bool bluetoothConnected: Bluetooth.devices.count > 0
    // property bool bluetoothConnected: Bluetooth.devices.values.length > 0
    property bool bluetoothConnected: false
    readonly property int iconSize: 30
    readonly property int pillHeight: 22
    readonly property int pillPaddingHorizontal: 20
    readonly property int pillOverlap: iconSize / 2

    property int maxPillWidth: 0
    property bool showPercentage: true

    // Dark theme colors (matching our bar theme)

    readonly property color surfaceVariant: "#333333"
    readonly property color accentPrimary: "#4a9eff"
    readonly property color textPrimary: "#ffffff"
    readonly property color backgroundPrimary: "#1a1a1a"

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        Rectangle {
            id: iconCircle
            width: iconSize
            height: iconSize
            radius: width / 2
            color: surfaceVariant
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            smooth: true

            Behavior on color {
                ColorAnimation { duration: 200; easing.type: Easing.InOutQuad }
            }
        }
        Text {
            id: icon
            anchors.centerIn: iconCircle
            font.family: "Material Symbols Outlined"
            font.pixelSize: 20
            color: "white"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            text: {
                if (bluetoothConnected)
                    return "󰂱"
                else if (bluetoothOn)
                    return "󰂯"
                else 
                    return "󰂲"
            }
        }
        MouseArea {
            anchors.fill: iconCircle
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: function(mouse) {
                if (mouse.button == Qt.LeftButton) {
                    // bluetoothOn = true
                    // Left click: toggle Bluetooth
                    Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled
                    Quickshell.execDetached([
                        "notify-send",
                        "Bluetooth",
                        !Bluetooth.defaultAdapter.enabled ? "Disabled" : "Enabled"
                    ])
                } else if (mouse.button === Qt.RightButton) {
                    // Right click: open blueman
                    Quickshell.execDetached(["blueman-manager"])
                    // Qt.openUrlExternally("blueman")
                }
            }
        } 

    }
}
