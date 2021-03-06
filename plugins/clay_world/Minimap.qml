// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file
import QtQuick 2.12

Rectangle {
    id: theMinimap

    property ClayWorld world: null
    property var typeMapping: new Map()

    readonly property var _observed: world.coordSys
    readonly property real _xScale: (1.0 * width)/_observed.width
    readonly property real _yScale: (1.0 * height)/_observed.height
    Component.onCompleted: world.worldCreated.connect(onWorldCreated);

    function onWorldCreated() {
        _observed.childrenChanged.connect(_updateContent);
        _observed.widthChanged.connect(_updateContent);
        _observed.heightChanged.connect(_updateContent);
        world.worldCreated.connect(_updateContent);
        _updateContent();
    }

    onWidthChanged: _updateContent()
    onHeightChanged: _updateContent()
    signal _cleanUp()

    function _typeAsString(obj){
        let typeStr = obj.toString();
        let idx = typeStr.indexOf("_");
        if (idx > -1)
            return typeStr.substring(0, idx);
        else
            return "";
    }

    function _updateContent() {
        if (!theMinimap) return;
        _cleanUp();
        for (let i=1; i<_observed.children.length; ++i){
            let o = _observed.children[i];
            // Skip object that may be already destroyed
            if (!o) continue;
            let typStr = _typeAsString(o);
            if (theMinimap.typeMapping.has(typStr)) {
                let comp = theMinimap.typeMapping.get(typStr);
                let obj = comp.createObject(theMinimap,
                                            {
                                                width: o.width * _xScale,
                                                height: o.height * _yScale
                                            });
                obj.x = Qt.binding(function() {return o.x * _xScale});
                obj.y = Qt.binding(function() {return o.y * _yScale});
                theMinimap._cleanUp.connect(obj.destroy)
            }
        }
    }

}
