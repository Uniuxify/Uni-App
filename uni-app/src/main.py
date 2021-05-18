import os
from pathlib import Path
import sys


from PySide6 import QtCore, QtGui, QtQml

import coingate
from app import BlocksModel, CurrencyListModel


def qt_message_handler(mode, context, message):
    if mode == 4:
        mode = 'Info'
    elif mode == 1:
        mode = 'Warning'
    elif mode == 2:
        mode = 'critical'
    elif mode == 3:
        mode = 'fatal'
    else:
        mode = 'Debug'
    print("%s: %s (%s:%d, %s)" % (mode, message, context.file, context.line, context.file))


if __name__ == "__main__":
    QtCore.qInstallMessageHandler(qt_message_handler)
    app = QtGui.QGuiApplication(sys.argv)
    engine = QtQml.QQmlApplicationEngine()

    blocks_model = BlocksModel()
    Path('../saves').mkdir(parents=True, exist_ok=True)
    try:
        blocks_model.load(open("../saves/save.json"))
    except FileNotFoundError:
        pass
    currency_list_model = CurrencyListModel(coingate.get_currency_list())
    engine.rootContext().setContextProperty("blockModel", blocks_model)
    engine.rootContext().setContextProperty("currencyListModel", currency_list_model)

    engine.load(os.fspath(Path(__file__).resolve().parent.parent / "res/ui/Index.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    exit_code = app.exec()
    blocks_model.save()
    sys.exit(exit_code)
