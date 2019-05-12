import QtQuick 2.12
import Box2D 2.0

VisualizedCircleBody
{
    id: thePlayer
    bodyType: Body.Dynamic
    color: "#3fa4c8"
    bullet: true
    property real maxYVelo: 8
    property real maxXVelo: 8
    categories: Box.Category2
    collidesWith: Box.Category1
    property bool isPlayer: true
    property int energy: 10000
    readonly property int maxEnergy: 10000
    opacity: energy/maxEnergy
    fixedRotation: Math.abs(linearVelocity.x) < 0.1 || !isOnGround
    property alias text: annotation.text
            density: 300.
            friction: isOnGround ? 10. : 1
            restitution: 0.

    property bool moveLeft: false
    onMoveLeftChanged: updateVelocity()
    property bool moveRight: false
    onMoveRightChanged: updateVelocity()
    function updateVelocity(){
        let newXVelo = 0;
        if (moveLeft) newXVelo = -maxXVelo;
        if (moveRight) newXVelo = maxXVelo;
        linearVelocity.x = newXVelo;
    }
    Timer {
        interval: 50
        repeat: true
        running: true
        onTriggered: updateVelocity()
    }


    property bool isOnGround: !(fallDownTimer.running) && Math.abs(linearVelocity.y) < 0.01
    function jump() { if (isOnGround){ reJumpTimer.restart() } }
    Timer {
        interval: 10
        running: reJumpTimer.running
        repeat: true
        onTriggered: linearVelocity.y = -1 * maxYVelo
    }
    Timer { id: reJumpTimer; interval: 300; onTriggered: fallDownTimer.restart() }
    Timer { id: fallDownTimer; interval: 200; }

    ScalingText
    {
        id: annotation
        parent: thePlayer.parent
        x: thePlayer.x + thePlayer.width/2 - width/2
        y: thePlayer.y - height * 1.1
        z: 99
        text: "(" + thePlayer.moveLeft + "," + thePlayer.moveRight + ")"
        color: "#3fa4c8"
        pixelPerUnit: thePlayer.pixelPerUnit
        fontSizeWu: 0.3
    }
}
