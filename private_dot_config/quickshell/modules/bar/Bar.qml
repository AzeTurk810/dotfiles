import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Bluetooth
import "./Widgets"

Variants {
    id: multiScreenars
    model: Quickshell.screens

    property int volume: 0
    property bool volumeMuted: false
    property var defaultAudioSink

    PanelWindow {
        id:panel

        required property var modelData 
        screen: modelData
        property var isSpecial: false

        // property bool showSpecial: false
        function isSpecialWorkspace(ws) {
            return ws.name && ws.name.startsWith("special:")
        }
        property bool showSpecial: {
            // return true
            var currentMonitor = Hyprland.monitors.values.find(function(m) { 
                return m.name === (panel.screen ? panel.screen.name : "") 
            });
            return (currentMonitor && currentMonitor.specialWorkspace);
        }

        anchors {
            top: true
            left: true
            right: true
        }
        // implicitBackgroundColor: "transparent"
        color: "transparent"

        implicitHeight: 38
        margins {
            top: 2
            left: 2
            right: 2
            bottom: -10
        }

        Rectangle {
            id: bar
            anchors.fill: parent
            color: "transparent" /// NOTE: color of entire bar's background
            // color: "#1a1111"
            radius: 15
            border.color: "#33c1ee" /// NOTE: color of entire bar's border color
            border.width: 3

            Row {
                id: workspaceRow /// NOTE:

                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 16
                } 
                spacing: 8

                Repeater {

                    // panel.showSpecial = panel.isAnySpecialActive()
                    // if (atspecial) {
                    //
                    // } else {
                    //     ;
                    // }
                    // model: Hyprland.workspaces.filter(false)
                    // model: Hyprland.workspaces
                    // model: Hyprland.workspaces.filter(function(ws) {
                    //     return panel.showSpecial
                    //         ? panel.isSpecialWorkspace(ws)
                    //         : !panel.isSpecialWorkspace(ws)
                    // })
                    model: ScriptModel {
                        values: Hyprland.workspaces.values.filter(function(ws) {
                            return panel.isSpecial
                            ? panel.isSpecialWorkspace(ws)
                            : !panel.isSpecialWorkspace(ws)
                        })
                    }

                    Rectangle { /// NOTE: our workspaces
                        width: 36
                        height: 24
                        radius: 15
                        color: modelData.active ? "#4a9eff" : "#333333"
                        // color: (Hyprland.focusedMonitor.specialWorkspace === modelData) ? "#4a9eff" : "#333333"
                        border.color: "#555555"
                        border.width: 2

                        /// NOTE: Make workspaces clickable
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                modelData.activate() 
                                // panel.showSpecial ^= 1
                            }
                        }

                        Text {
                            text: {
                                if (modelData.name == "special:communication") {
                                    return "💬"
                                } else if (modelData.name == "special:music") {
                                    return "🎵"
                                }
                                return modelData.name
                            }
                            anchors.centerIn: parent
                            color: modelData.active ? "#ffffff" : "#cccccc"
                            font.pixelSize: 12
                            font.family: "Inter, sans-serif"
                        }
                    }
                }

                Text {
                    visible: Hyprland.workspaces.values.length === 0
                    text: "No workspaces"
                    color: "#ffffff"
                    font.pixelSize: 12
                }
            }

            Text {
                id: name
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 16
                }
                property string appName: "AzeTurk810"
                text: appName
                color: "#ffffff"
            }

            // Bluetooth icon
            Bluetooth {
                id: bluetoothWidget
                anchors {
                    right: volumeWidget.left
                    verticalCenter: parent.verticalCenter
                    rightMargin: 8
                }
                shell: multiScreenars
                // bluetoothOn: multiScreenars.bluetoothOn
                // bluetoothConnected: Bluetooth.devices.values.length > 0
            }

            // Volume widget in the center-right area
            Volume {
                id: volumeWidget
                anchors {
                    // left: name.left
                    right: name.left
                    verticalCenter: parent.verticalCenter
                    rightMargin: 10
                }
                shell: multiScreenars // pass multiScreenars as shell referance
                volume: multiScreenars.volume
                volumeMuted: multiScreenars.volumeMuted
            }

            // timeDisplay at Center
            Text {
                id: timeDisplay
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }

                property string currentTime: ""
                text: currentTime
                color: "#ffffff"
                font.pixelSize: 14
                font.family: "Inter, sans-serif"

                Timer {
                    interval: 1000
                    running: true
                    repeat: true

                    onTriggered: {
                        var now = new Date()
                        timeDisplay.currentTime =
                        Qt.formatDate(now, "MMM dd") + " " +
                        Qt.formatTime(now, "HH:mm:ss")
                    }
                }

                Component.onCompleted: {
                    var now = new Date()
                    timeDisplay.currentTime =
                    Qt.formatDate(now, "MMM dd") + " " +
                    Qt.formatTime(now, "HH:mm:ss")
                }
            }
        }
    }
}
