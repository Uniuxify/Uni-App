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
                model: blockModel
                delegate: CurrencyExcangeRateBlock {
                    width: currencyBlocks.width
                    onClosed: currencyBlocks.model.removeRow(display.obj_id)
                    onImplicitWidthChanged: currencyBlocks.implicitWidth = implicitWidth > currencyBlocks.implicitWidth ? implicitWidth : currencyBlocks.implicitWidth
                    onRateChanged: {
                        display.rate = parseFloat(rate)
                        console.log("rate=" + display.rate)
                        rate = display.rate
                        n1 = display.n1
                        n2 = display.n2
                    }
                    onUpdateRate: {
                        display.update_rate()
                        rate = display.rate
                        n1 = display.n1
                        n2 = display.n2
                        source = display.source
                        quote = display.quote
                    }

                    onN1Changed: {
                        display.n1 = parseFloat(n1)
                        console.log("n1="+display.n1)
                        n1 = display.n1
                        n2 = display.n2
                    }
                    onN2Changed: {
                        display.n2 = parseFloat(n2)
                        console.log("n2="+display.n2)
                        n1 = display.n1
                        n2 = display.n2
                    }
                    onSwap: {
                        display.swap()
                        rate = display.rate
                        n1 = display.n1
                        n2 = display.n2
                        source = display.source
                        quote = display.quote
                    }
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
                        onReleased: {
                            clear.source = "clear-selected.png"
                            currencyBlocks.model.clear()
                        }
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
                        onReleased: {
                            add.source = "add-selected.png"
                            currencyBlocks.model.append()
                        }
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

            function updateModel(index, newModel) {
                currencyBlocks.model.set(index, newModel)
            }



    }
}
