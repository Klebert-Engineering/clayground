// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import Box2D 2.0
import Clayground.Physics 1.0
import Clayground.Svg 1.0

VisualizedBoxBody
{
    SvgImageSource {
        id: svg
        svgFilename: "visuals"
        annotationAARRGGBB:"ff000000"
    }
    source:  svg.source("box")
    bodyType: Body.Static
    color: "#7084aa"
    categories: Box.Category1
    collidesWith: Box.Category2 | Box.Category3
}