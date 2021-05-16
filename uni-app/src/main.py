# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys


from PySide6 import QtCore, QtGui, QtQml


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
    engine.load(os.fspath(Path(__file__).resolve().parent.parent / "res/ui/Index.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
