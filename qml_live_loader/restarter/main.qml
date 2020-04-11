/*
 * This file is part of Clayground (https://github.com/MisterGC/clayground)
 *
 * This software is provided 'as-is', without any express or implied warranty.
 * In no event will the authors be held liable for any damages arising from
 * the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software in
 *    a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 *
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 *
 * 3. This notice may not be removed or altered from any source distribution.
 *
 * Authors:
 * Copyright (c) 2019 Serein Pfeiffer <serein.pfeiffer@gmail.com>
 */
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

Window {
    id: theWindow

    visible: true
    x: Screen.desktopAvailableWidth * .01
    y: Screen.desktopAvailableHeight * .01
    width: Screen.desktopAvailableWidth * .32
    height: Screen.desktopAvailableHeight * .2
    title: qsTr("Clay Dev Session")
    opacity: .95

    property int nrRestarts: 0
    property string currError: ""

    Component.onCompleted: keyvalues.set("nrRestarts", 0);

    Timer {
        running: true
        repeat: true
        interval: 500
        onTriggered: {
            nrRestarts = keyvalues.get("nrRestarts", 0)
            currError = keyvalues.get("lastErrorMsg", 0)
        }
    }

    Rectangle
    {
        color: "black"
        anchors.fill: parent

        // TODO Utilize Layouts instead of manually tweaking sizes and margins
        Column {
            spacing: parent.height * 0.04
            anchors { top: parent.top; topMargin: spacing}

            Row {
                anchors { left: parent.left; leftMargin: watch.width * .05}
                spacing: watch.width * .05
                SciFiWatch {id: watch; width: theWindow.width * .6 }
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        id: lbl
                        text: "#Restarts"
                        color: watch.secondsColor
                        font.pixelSize: watch.height * .20
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: nrRestarts
                        color: lbl.color
                        font.pixelSize: lbl.font.pixelSize * 1.8
                    }
                }
            }

            Text {
                id: briefStatus

                anchors.horizontalCenter: parent.horizontalCenter
                color: blinkColor
                horizontalAlignment: Text.AlignHCenter
                font.family: "Monospace"
                font.pixelSize: watch.width * 0.06
                text: errDetected ? "<b>CRITICAL ERROR</b>" : "All Systems up and running"

                property color blinkColor: errDetected ? "#D64545" : watch.secondsColor
                property bool errDetected: currError !== ""

                SequentialAnimation on color {
                    running: briefStatus.errDetected
                    loops: Animation.Infinite
                    ColorAnimation {
                        from: briefStatus.blinkColor
                        to: Qt.darker(briefStatus.blinkColor, 1.4)
                        duration: 3000
                    }
                    ColorAnimation {
                        from: Qt.darker(briefStatus.blinkColor, 1.4)
                        to: briefStatus.blinkColor
                        duration: 2000
                    }
                }

            }

            ScrollView {
                id: errDetails

                visible: briefStatus.errDetected
                width: theWindow.width
                height: theWindow.height * .25

                TextArea {
                    enabled: false
                    textFormat: TextEdit.RichText
                    wrapMode: Text.Wrap
                    horizontalAlignment:Text.AlignHCenter
                    width: parent.width
                    color: briefStatus.blinkColor
                    text: theWindow.currError
                    font.family: "Monospace"
                }
            }
        }
    }

    KeyValueStorage { id: keyvalues; name: "clayrtdb" }
    Connections {
        target: ClayRestarter
        onRestarted: {
            let r = parseInt(keyvalues.get("nrRestarts", 0)) + 1;
            keyvalues.set("nrRestarts", r);
        }
    }
}