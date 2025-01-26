import QtQuick 2.15
import QtQuick.Controls 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Social Media Monitor")
    Loader {
        id: rootLoader
        anchors.fill: parent
        source: "qrc:/MainContent.qml"
        }


}
