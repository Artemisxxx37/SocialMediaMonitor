import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    width: 640
    height: 480
    color: "transparent"

    Component.onCompleted: {
        console.log("Registration page loaded")
    }

    // Background image for the registration page
    Image {
        source: "qrc:/images/background.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    Column {
        anchors.centerIn: parent
        spacing: 10

        // Animated Registration/Login Text
        Text {
            id: pageTitle
            text: "Registration Page"
            font.pixelSize: 24
            color: "white"
            SequentialAnimation {
                loops: Animation.Infinite
                NumberAnimation { target: this; property: "scale"; from: 1; to: 1.1; duration: 1000 }
                NumberAnimation { target: this; property: "scale"; from: 1.1; to: 1; duration: 1000 }
            }
        }

        // Username Input Field
        TextField {
            id: usernameField
            placeholderText: "Username"
            width: 200
            font.pixelSize: 16
            font.family: "Arial"
            color: "#351f67"
            background: Rectangle {
                color: "#eacff8"  // Background color for input field
                radius: 5
            }
            Rectangle {
                anchors.fill: parent
                border.color: "white"
                border.width: 1
                color: "transparent"
                radius: 5
            }
        }

        // Password Input Field
        TextField {
            id: passwordField
            placeholderText: "Password"
            width: 200
            font.pixelSize: 16
            font.family: "Arial"
            color: "#351f67"
            echoMode: TextInput.Password  // Hide the password text
            background: Rectangle {
                color: "#eacff8"  // Background color for input field
                radius: 5
            }
            Rectangle {
                anchors.fill: parent
                border.color: "white"
                border.width: 1
                color: "transparent"
                radius: 5
            }
        }

        // Register/Login Button
        Button {
            id: actionButton
            text: "Register"
            font.pixelSize: 16
            background: Rectangle {
                color: "#a11477"
                radius: 5
                border.color: "white"
                border.width: 1
            }
            onClicked: {
                if (usernameField.text !== "" && passwordField.text !== "") {
                    if (registeredCheckBox.checked) {
                        // Handle login logic here
                        if (database.loginUser(usernameField.text, passwordField.text)) {
                            console.log("User logged in!")
                            // Redirect to another page or show success message
                        } else {
                            console.log("Login failed!")
                        }
                    } else {
                        // Handle registration logic here
                        if (!database.userExists(usernameField.text)) {
                            if (database.registerUser(usernameField.text, passwordField.text)) {
                                console.log("User registered!")
                                registeredCheckBox.checked = true  // Redirect to login
                            } else {
                                console.log("Registration failed!")
                            }
                        } else {
                            console.log("Username already exists")
                        }
                    }
                } else {
                    console.log("Both fields are required")
                }
            }
        }

        // CheckBox to toggle between registration and login
        CheckBox {
            id: registeredCheckBox
            text: "Already registered? Login instead"
            font.pixelSize: 16
            onCheckedChanged: {
                if (checked) {
                    pageTitle.text = "Login Page"
                    actionButton.text = "Login"
                } else {
                    pageTitle.text = "Registration Page"
                    actionButton.text = "Register"
                }
            }
        }

        // Back Button
        Button {
            text: "Back"
            font.pixelSize: 16
            background: Rectangle {
                color: "#a11477"
                radius: 5
                border.color: "white"
                border.width: 1
            }
            onClicked: {
                // Handle back navigation logic
                rootLoader.source = "qrc:/MainContent.qml"
            }
        }
    }
}
