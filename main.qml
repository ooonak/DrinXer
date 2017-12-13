import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("DrinXer")

    Item {
        id: podo
        property var calibrationDuration: 0
    }

    Connections {
        target: pumpController
        onDuration: {
            podo.calibrationDuration = ms
        }
    }

    StackView {
        id: stack
        initialItem: mainView
        anchors.fill: parent

        Component {
            id: mainView

            Pane {
                Material.elevation: 6
                anchors.centerIn: parent

                ColumnLayout {
                    anchors.centerIn: parent

                    Label {
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                        }
                        text: qsTr("Make a selection")
                    }

                    Button {
                        Layout.fillWidth: true
                        Material.foreground: Material.Pink
                        text: qsTr("Rom & Cola")
                        onClicked: {
                            //stack.push(romColaView)
                        }
                    }

                    Button {
                        Layout.fillWidth: true
                        Material.foreground: Material.Pink
                        text: qsTr("Gin & Tonic")
                        onClicked: {
                            //stack.push(romColaView)
                        }
                    }

                    Button {
                        Layout.fillWidth: true
                        Material.foreground: Material.Pink
                        text: qsTr("Skinny Bitch")
                        onClicked: {
                            //stack.push(romColaView)
                        }
                    }

                    Button {
                        Layout.fillWidth: true
                        Material.foreground: Material.Pink
                        text: qsTr("Settings")
                        onClicked: {
                            stack.push(settingsView)
                        }
                    }
                } // ColumnLayout
            } // Pane
        } // Component

        Component {
            id: settingsView

            Pane {
                Material.elevation: 6
                anchors.centerIn: parent

                ColumnLayout {
                    anchors.centerIn: parent

                    GridLayout {
                        columns: 2

                        Dial {
                            id: selectPumpDial
                            from: 1
                            to: 6
                            stepSize: 1
                            snapMode: Dial.SnapAlways

                            onMoved: {
                                pumpLabel.text = qsTr("Pump " + value)
                            }
                        }

                        Dial {
                            id: selectVolumeDial
                            from: 2
                            to: 10
                            stepSize: 1
                            snapMode: Dial.SnapAlways

                            onMoved: {
                                volumeLabel.text = qsTr("Volume " + value + " cl")
                            }
                        }

                        Label {
                            id: pumpLabel
                            text: qsTr("Pump " + selectPumpDial.value)
                        }

                        Label {
                            id: volumeLabel
                            text: qsTr("Volume " + selectVolumeDial.value + " cl")
                        }
                    } // GridLayout

                    Button {
                        id: startButton
                        Layout.fillWidth: true
                        Material.foreground: Material.Pink
                        text: qsTr("Start calibration")
                        onClicked: {
                            startButton.enabled = !startButton.enabled
                            stopButton.enabled = !stopButton.enabled
                            selectPumpDial.enabled = !selectPumpDial.enabled
                            selectVolumeDial.enabled = !selectVolumeDial.enabled
                            pumpController.startPump(selectPumpDial.value)
                        }
                    }

                    Button {
                        id: stopButton
                        enabled: false
                        Layout.fillWidth: true
                        Material.foreground: Material.Pink
                        text: qsTr("Stop calibration")
                        onClicked: {
                            stopButton.enabled = !stopButton.enabled
                            calibrateButton.enabled = !calibrateButton.enabled
                            pumpController.stopPump(selectPumpDial.value)
                        }
                    }

                    Button {
                        id: calibrateButton
                        enabled: false
                        Layout.fillWidth: true
                        Material.foreground: Material.Pink
                        text: qsTr("Set calibration")
                        onClicked: {
                            pumpController.setCalibrationValue(selectPumpDial.value, ((selectVolumeDial.value * 1000000000) / podo.calibrationDuration) )
                            selectPumpDial.enabled = !selectPumpDial.enabled
                            selectVolumeDial.enabled = !selectVolumeDial.enabled
                            startButton.enabled = !startButton.enabled
                            calibrateButton.enabled = !calibrateButton.enabled
                        }
                    }

                    Button {
                        Layout.fillWidth: true
                        Material.foreground: Material.Pink
                        text: qsTr("Back")
                        onClicked: {
                            stack.pop()
                        }
                    }
                } // ColumnLayout
            } // Pane
        } // Component
    }
}
