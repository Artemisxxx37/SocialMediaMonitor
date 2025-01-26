import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    width: 640
    height: 480
    color: "transparent"

    Image {
        id: background
        source: "qrc:/images/background.jpg"  // Ensure this path is correct
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    Image {
        id: vortex
        source: "qrc:/images/vortex.jpeg"  // Ensure this path is correct
        width: 150
        height: 150
        anchors.centerIn: parent
        RotationAnimator on rotation {
            from: 0
            to: 360
            loops: Animation.Infinite
            duration: 4500  // Adjust the duration as needed
        }
    }

    Text {
        id: helloText
        text: "Social Media Monitor"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -100  // Position text above the vortex
        color: "#a11477"  // Adjust text color for better visibility
        font.pixelSize: 38  // Change text size
        font.family: "Hack Bold"  // Change font
    }

    Text {
        id: clickedText
        text: "->START<-"
        anchors.centerIn: parent
        color: "#7c4fd0"
        font.pixelSize: 24
        font.family: "Hack Bold"
        visible: true  // Initially shown
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            helloText.visible = false  // Hide the "Social Media Monitor" text
            clickedText.text = "Clicked!"
            clickedText.visible = true  // Show the "Clicked!" text
            rootLoader.source = "qrc:/Registration.qml"  // Load registration page on click
        }
    }

    // Add a simple animation effect for the "Social Media Monitor" text
    SequentialAnimation {
        id: textAnimation
        running: true
        loops: Animation.Infinite
        PropertyAnimation { target: helloText; property: "opacity"; from: 0.5; to: 1.0; duration: 1000 }
        PropertyAnimation { target: helloText; property: "opacity"; from: 1.0; to: 0.5; duration: 1000 }
    }
}
