import QtQuick 2.12
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
Item {
    id: root

    property string n1: "1"
    property string n2: "1"
    property string rate: "1"
    property string source: "USD"
    property string quote: "USD"

    signal updateRate()
    signal swap()
    signal closed()

    height: 180
    implicitWidth: Math.max(row1.implicitWidth, row2.implicitWidth) + 40 + 31

    Rectangle {
        anchors.fill: parent
        color: "#0cffffff"
        radius: 43
        FontLoader {
            id: roboto
            source: "fonts/Roboto-Black.ttf"
        }
        Item {
            anchors.fill: parent
            anchors.margins: 35
            /*
             *  ROW1
             */
            RowLayout {
                clip: true
                id: row1
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
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

                ComboBox {
                    id: control
                    textRole: "display"
                    model: currencyListModel
                    font.family: "Roboto"
                    font.pixelSize: 35
                    Layout.alignment : Qt.AlignTop
                    Layout.topMargin: -5
                    displayText: root.source
                    Component.onCompleted: {
                        currentIndex = find(root.source)
                    }
                    onActivated: {
                        root.source = textAt(currentIndex)
                    }
                    contentItem: Text {
                        text: control.displayText
                        font: control.font
                        color: control.pressed ? "#17a81a" : "#00BC13"
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }

                    background: Rectangle {
                        color: "transparent"
                    }

                    popup: Popup {
                        y: control.height - 1
                        width: control.width
                        implicitHeight: contentItem.implicitHeight
                        padding: 1

                        contentItem: ListView {
                            clip: true
                            implicitHeight: contentHeight
                            model: control.popup.visible ? control.delegateModel : null
                            currentIndex: control.highlightedIndex

                            ScrollIndicator.vertical: ScrollIndicator { }
                        }

                        background: Rectangle {
                            border.color: "#21be2b"
                            radius: 2
                        }
                    }

                }

                Text {
                    id:text12
                    color: "#BCBCBC"
                    text: "="
                    font.family: "Roboto"
                    font.pixelSize: 35
                    Layout.alignment : Qt.AlignTop
                    Layout.leftMargin: -15
                }
                Item {
                    id: text13
                    Layout.topMargin: 3
                    Layout.leftMargin: -7
                    Layout.alignment : Qt.AlignTop
                    height: text12.height
                    Text {
                        id: errorMsg
                        text: ""
                        color: "#ccF92525"
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.bottomMargin: -7
                        anchors.leftMargin: -3
                    }
                    TextField {
                        id: text_field13
                        property string rateTextBuffer: ""
                        Component.onCompleted: text_field13.ensureVisible(0)
                        onEditingFinished: text_field13.ensureVisible(0)
                        onImplicitWidthChanged: { parent.implicitWidth = implicitWidth }
                        onTextChanged: {
                            if(text != "" && text != "0") {
                                root.rate = text
                                rateTextBuffer = text
                                errorMsg.text = ""
                            } else {
                                errorMsg.text = "*rate cannot be zero"
                            }
                        }
                        anchors.fill: parent
                        text: {
                            if(!activeFocus)
                                return rate
                            return rateTextBuffer
                        }
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


                ComboBox {
                    id: control2
                    textRole: "display"
                    model: currencyListModel
                    font.family: "Roboto"
                    font.pixelSize: 35
                    Layout.alignment : Qt.AlignTop
                    Layout.topMargin: -5
                    displayText: root.quote
                    onActivated: {
                        root.quote = textAt(currentIndex)
                    }
                    Component.onCompleted: {
                        currentIndex = find(root.quote)
                    }
                    contentItem: Text {
                        text: control2.displayText
                        font: control2.font
                        color: control2.pressed ? "#17a81a" : "#00BC13"
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }

                    background: Rectangle {
                        color: "transparent"
                    }

                    popup: Popup {
                        y: control2.height - 1
                        width: control2.width
                        implicitHeight: contentItem.implicitHeight
                        padding: 1

                        contentItem: ListView {
                            clip: true
                            implicitHeight: contentHeight
                            model: control2.popup.visible ? control2.delegateModel : null
                            currentIndex: control2.highlightedIndex

                            ScrollIndicator.vertical: ScrollIndicator { }
                        }

                        background: Rectangle {
                            border.color: "#21be2b"
                            radius: 2
                        }
                    }

                }
                FocusScope  {
                    id: update_focus
                    height: 40
                    width: 40
                    Layout.alignment : Qt.AlignTop
                    MouseArea {
                        id: mouseArea1
                        anchors.fill: parent
                        hoverEnabled: true
                        onPressed: {
                            update.source = "update-pressed.png"
                            update_focus.forceActiveFocus()
                        }
                        onReleased: {
                            update.source = "update-glow.png"
                            updateRate()
                        }
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
            }

            /*
             *  ROW2
             */
            RowLayout {
                id: row2
                clip: true
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
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
                        property string n1TextBuffer: ""
                        Component.onCompleted: text_field21.ensureVisible(0)
                        onEditingFinished: text_field21.ensureVisible(0)
                        onImplicitWidthChanged: { parent.implicitWidth = implicitWidth}
                        onTextChanged: {
                            if(text != "") {
                               root.n1 = text
                               n1TextBuffer = text
                            }
                        }
                        anchors.fill: parent
                        text: {
                            if(!activeFocus)
                                return n1
                            return n1TextBuffer
                        }
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
                    text: source
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
                        property string n2TextBuffer: ""
                        Component.onCompleted: text_field24.ensureVisible(0)
                        onEditingFinished: text_field24.ensureVisible(0)
                        onImplicitWidthChanged: { parent.implicitWidth = implicitWidth}
                        onTextChanged: {
                            if(text != "") {
                                root.n2 = text
                                n2TextBuffer = text
                            }
                        }
                        anchors.fill: parent
                        text: {
                            if(!activeFocus)
                                return n2
                            return n2TextBuffer
                        }
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
                    text: quote
                    font.family: "Roboto"
                    font.pixelSize: 35
                    Layout.alignment : Qt.AlignBottom
                }
                FocusScope {
                    id: swap_focus
                    height: 40
                    width: 40
                    Layout.alignment : Qt.AlignBottom
                    MouseArea {
                        id: mouseArea2
                        anchors.fill: parent
                        hoverEnabled: true
                        onPressed: {
                            swapImg.source = "swap-pressed.png"
                            swap_focus.forceActiveFocus()
                        }
                        onReleased: {
                            swapImg.source = "swap-glow.png"
                            swap()
                        }
                        onExited: { swapImg.source = "swap.png" }
                        onEntered: { swapImg.source = "swap-glow.png" }
                    }
                    Image {
                        id: swapImg
                        source: "swap.png"
                        anchors.fill: parent
                    }
                }
                Item {
                    Layout.fillWidth: true
                }
            }
        }
        Item {
            height: 31
            width: 31
            anchors.rightMargin: 18
            anchors.topMargin: 13
            anchors.top: parent.top
            anchors.right: parent.right
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

}
