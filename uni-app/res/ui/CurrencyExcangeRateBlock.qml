import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
Item {
    height: 180
    property string n1: ""
    property string n2: ""
    property string rate: ""
    property string currency1: "UNI"
    property string currency2: "UNI"
    implicitWidth: Math.max(row1.implicitWidth, row2.implicitWidth) + 40 + 31
    signal closed()
    Rectangle {
        anchors.fill: parent
        color: "#0cffffff"
        radius: 43
        FontLoader {
            id: roboto
            source: "fonts/Roboto-Black.ttf"
        }
        /*
         *  ROW1
         */
        RowLayout {
            id: row1
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 28
            anchors.leftMargin: 28
            height: parent.height*0.5
            spacing: 10
            Text {
                id:text10
                color: "#BCBCBC"
                text: "1"
                font.family: "Roboto"
                font.pixelSize: 35
                Layout.alignment : Qt.AlignTop
            }

            Text {
                id:text11
                color: "#00BC13"
                text: currency1
                font.family: "Roboto"
                font.pixelSize: 35
                Layout.alignment : Qt.AlignTop
            }
            Text {
                id:text12
                color: "#BCBCBC"
                text: "="
                font.family: "Roboto"
                font.pixelSize: 35
                Layout.alignment : Qt.AlignTop
            }
            Item {
                id: text13
                Layout.topMargin: 3
                Layout.leftMargin: -7
                Layout.alignment : Qt.AlignTop
                height: text12.height
                TextField {

                    id: text_field13
                    Component.onCompleted: text_field13.ensureVisible(0)
                    onEditingFinished: text_field13.ensureVisible(0)
                    onImplicitWidthChanged: { parent.implicitWidth = implicitWidth - 55 }


                    anchors.fill: parent
                    text: rate
                    placeholderText: "..."
                    placeholderTextColor: "#717171"
                    color: "#BCBCBC"
                    font.family: "Roboto"
                    font.pixelSize: 35
                    Layout.alignment : Qt.AlignTop
                    validator: DoubleValidator {bottom: 1}
                    background: Item {
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height
                    }
                }
            }
            Text {
                id:text14
                color: "#00BC13"
                text: currency2
                font.family: "Roboto"
                font.pixelSize: 35
                Layout.alignment : Qt.AlignTop
            }
            Item {
                height: 40
                width: 40
                Layout.alignment : Qt.AlignTop
                MouseArea {
                    id: mouseArea1
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: { update.source = "update-pressed.png" }
                    onReleased: { update.source = "update-glow.png" }
                    onExited: { update.source = "update.png" }
                    onEntered: { update.source = "update-glow.png" }
                }
                Image {
                    id: update
                    anchors.fill: parent
                    source: "update.png"
                }
            }
            Item {
                Layout.fillWidth: true
            }
            Item {
                height: 31
                width: 31
                Layout.rightMargin: 18
                Layout.topMargin: -13
                Layout.alignment : Qt.AlignTop
                MouseArea {
                    id: mouseArea3
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: { remove.source = "remove-pressed.png" }
                    onReleased: {
                                  remove.source = "remove-glow.png"
                                  closed()
                                 }
                    onExited: { remove.source = "remove.png" }
                    onEntered: { remove.source = "remove-glow.png" }
                }
                Image {
                    id: remove
                    anchors.fill: parent
                    source: "remove.png"
                }
            }
        }

        /*
         *  ROW2
         */
        RowLayout {
            id: row2
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottomMargin: 33
            anchors.leftMargin: 28
            height: parent.height * 0.5
            spacing: 10
            Item {
                Layout.bottomMargin: -3
                Layout.leftMargin: -7
                id: text21
                Layout.alignment : Qt.AlignBottom
                height: text23.height
                TextField {
                    id:text_field21
                    Component.onCompleted: text_field21.ensureVisible(0)
                    onEditingFinished: text_field21.ensureVisible(0)
                    onImplicitWidthChanged: { parent.implicitWidth = implicitWidth - 55 }
                    anchors.fill: parent
                    text: n1
                    placeholderText: "..."
                    placeholderTextColor: "#717171"
                    color: "#BCBCBC"
                    font.family: "Roboto"
                    font.pixelSize: 35
                    Layout.alignment : Qt.AlignBottom
                    validator: DoubleValidator {bottom: 1}
                    background: Item {
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height
                    }
                }
            }
            Text {
                id: text22
                color: "#00BC13"
                text: currency1
                font.family: "Roboto"
                font.pixelSize: 35
                Layout.alignment : Qt.AlignBottom
            }
            Text {
                id: text23
                color: "#BCBCBC"
                text: "="
                font.family: "Roboto"
                font.pixelSize: 35
                Layout.alignment : Qt.AlignBottom
            }
            Item {
                Layout.bottomMargin: -3
                Layout.leftMargin: -7
                id: text24
                Layout.alignment : Qt.AlignBottom
                height: text23.height
                TextField {
                    id:text_field24
                    Component.onCompleted: text_field24.ensureVisible(0)
                    onEditingFinished: text_field24.ensureVisible(0)
                    onImplicitWidthChanged: { parent.implicitWidth = implicitWidth - 55 }
                    anchors.fill: parent
                    text: n2
                    placeholderText: "..."
                    placeholderTextColor: "#717171"
                    color: "#BCBCBC"
                    font.family: "Roboto"
                    font.pixelSize: 35
                    Layout.alignment : Qt.AlignBottom
                    validator: DoubleValidator {bottom: 1}
                    background: Item {
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height
                    }
                }
            }
            Text {
                color: "#00BC13"
                text: currency2
                font.family: "Roboto"
                font.pixelSize: 35
                Layout.alignment : Qt.AlignBottom
            }
            Item {
                height: 40
                width: 40
                Layout.alignment : Qt.AlignBottom
                MouseArea {
                    id: mouseArea2
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: { swap.source = "swap-pressed.png" }
                    onReleased: { swap.source = "swap-glow.png" }
                    onExited: { swap.source = "swap.png" }
                    onEntered: { swap.source = "swap-glow.png" }
                }
                Image {
                    id: swap
                    source: "swap.png"
                    anchors.fill: parent
                }
            }
            Item {
                Layout.fillWidth: true
            }
        }

    }

}
