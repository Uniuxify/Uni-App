from PySide6 import QtCore, QtGui, QtQml

class Calculator(QtCore.QObject):
    @QtCore.Slot(float, float, str, str)
    def n1_changed(self, n1, n2, currency1, currency2):
        pass

    @QtCore.Slot
    def n2_changed(self, n1, n2, currency1, currency2):
        pass

    @QtCore.Slot
    def rate_changed(self, n1, n2, currency1, currency2):
        pass

    """ Вызывается после нажатия кнопки обновить у соответсвующего блока.
        Получает актуальные данные о курсе для соответсвующих валют и
        устанавливает в соответсвии с ними n1, n2, rate """
    @QtCore.Slot
    def updated_request(self, currency1, currency2):
        pass

    @QtCore.Slot
    def swapped_request(self, currency1, currency2):
        pass
