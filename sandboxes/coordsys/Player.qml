import QtQuick 2.12
import Box2D 2.0

VisualizedBoxBody
{
    bodyType: Body.Dynamic
    color: "#3fa4c8"
    bullet: true
    property real maxVelo: 8
    categories: Box.Category2
    collidesWith: Box.Category1

    function moveUp() { body.linearVelocity.y = -maxVelo; }
    function moveDown() { body.linearVelocity.y = maxVelo; }
    function moveLeft() { body.linearVelocity.x = -maxVelo; }
    function moveRight() { body.linearVelocity.x = maxVelo; }

    function stopUp() { if (body.linearVelocity.y < 0) body.linearVelocity.y = 0; }
    function stopDown() { if (body.linearVelocity.y > 0) body.linearVelocity.y = 0; }
    function stopLeft() { if (body.linearVelocity.x < 0) body.linearVelocity.x = 0; }
    function stopRight() { if (body.linearVelocity.x > 0) body.linearVelocity.x = 0; }

    ScalingText
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.top
        text: "Here I am!"
        pixelPerUnit: 1.0
    }
}
