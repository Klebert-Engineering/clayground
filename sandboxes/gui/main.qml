// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visibility: Window.Maximized
    visible: true
    title: qsTr("Gui")
    Sandbox { anchors.fill: parent }
    Component.onCompleted: if(Qt.platform.pluginName === "offscreen") Qt.quit()
}
