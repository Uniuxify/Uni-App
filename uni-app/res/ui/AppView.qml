import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0



Item {
    id: root
    property string main_bg: unfined

    Window {
        id: win
        x: 500
        y: 100
        // width: currencyBlocks.implicitWidth + 2 * currencyBlocks.anchors.rightMargin
        height: 432 * 2
        visible: true
        // minimumWidth: currencyBlocks.implicitWidth + 2 * currencyBlocks.anchors.rightMargin
        minimumWidth: 730
        title: qsTr("UniApp")
        Image {
            source: main_bg
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
        }


            ListView {
                id: currencyBlocks
                anchors.fill: parent
                anchors.topMargin: 20
                anchors.rightMargin: 30
                anchors.leftMargin: 30
                spacing: 10
                orientation: ListView.Vertical
                model: model
                delegate: CurrencyExcangeRateBlock {
                    rate: model.rate
                    n1: model.n1
                    n2: model.n2
                    currency1: model.currency1
                    currency2: model.currency2
                    width: currencyBlocks.width
                    onClosed: currencyBlocks.model.remove(model.index)
                    onImplicitWidthChanged: currencyBlocks.implicitWidth = implicitWidth > currencyBlocks.implicitWidth ? implicitWidth : currencyBlocks.implicitWidth
                }
            }
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.left: parent.left
                height: 90
                color: "#ee818181"
                Item {
                    width: 40
                    height: 40
                    anchors.right: add_icon.left
                    anchors.rightMargin: 30
                    anchors.bottomMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        id: mouseArea2
                        anchors.fill: parent
                        hoverEnabled: true
                        onPressed: { clear.source = "clear-pressed.png" }
                        onReleased: { clear.source = "clear-selected.png"
                                      currencyBlocks.model.clear()}
                        onExited: { clear.source = "clear.png" }
                        onEntered: { clear.source = "clear-selected.png" }
                    }
                    Image {
                        id: clear
                        anchors.fill: parent
                        source: "clear.png"
                    }
                }
                Item {
                    id: add_icon
                    width: 40
                    height: 40
                    anchors.right: parent.right
                    anchors.rightMargin: 30
                    anchors.bottomMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        id: mouseArea3
                        anchors.fill: parent
                        hoverEnabled: true
                        onPressed: { add.source = "add-pressed.png" }
                        onReleased: { add.source = "add-selected.png"
                                      currencyBlocks.model.append({"rate": "1","n1": "1","n2": "1","currency1": "UNI","currency2": "UNI"})}
                        onExited: { add.source = "add.png" }
                        onEntered: { add.source = "add-selected.png" }
                    }
                    Image {
                        id: add
                        anchors.fill: parent
                        source: "add.png"
                    }
                }
            }
            ListModel {
                id: model
                ListElement {
                    rate: "300000"
                    n1: "1000"
                    n2: "0.00035"
                    currency1: "RUB"
                    currency2: "ETH"
                }
                ListElement {
                    rate: "3000000000000"
                    n1: "1000"
                    n2: "0.000005"
                    currency1: "RUB"
                    currency2: "BTC"
                }
                ListElement {
                    rate: "300000"
                    n1: "1000"
                    n2: "0.00035"
                    currency1: "RUB"
                    currency2: "USD"
                }
            }
            function updateModel(index, newModel) {
                currencyBlocks.model.set(index, newModel)
            }



    }
}
