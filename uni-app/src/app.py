import coingate as cg_api
from PySide6 import QtCore
import json
import os


class CurrencyBlock(QtCore.QObject):
    def __init__(self, rate=1, n1=1, n2=1, source="USD", quote="USD"):
        super().__init__()
        self.__rate = rate
        self.__n1 = n1
        self.__n2 = n2
        self.__source = source
        self.__quote = quote

    @QtCore.Slot()
    def get_id(self):
        return str(id(self))

    @QtCore.Slot()
    def update_rate(self):
        try:
            self.rate = float(cg_api.get_rate(self.source, self.quote))
        except ValueError:
            pass

    def get_rate(self):
        return round(self.__rate, 7)

    @QtCore.Slot(float)
    def set_rate(self, rate):
        self.__rate = rate
        self.rateChanged.emit()
        self.update_n2()

    def update_n1(self):
        self.__n1 = self.n2 / self.rate
        self.n1Changed.emit()

    def get_n1(self):
        return round(self.__n1, 4)

    def set_n1(self, n1):
        self.__n1 = n1
        self.n1Changed.emit()
        self.update_n2()

    def update_n2(self):
        self.__n2 = self.n1 * self.rate
        self.n2Changed.emit()

    def get_n2(self):
        return round(self.__n2, 4)

    def set_n2(self, n2):
        self.__n2 = n2
        self.n2Changed.emit()
        self.update_n1()

    @QtCore.Slot()
    def swap(self):
        temp = self.quote
        self.quote = self.source
        self.source = temp

    def get_source(self):
        return self.__source

    def set_source(self, source):
        self.__source = source
        self.update_rate()

    def get_quote(self):
        return self.__quote

    def set_quote(self, quote):
        self.__quote = quote
        self.update_rate()

    rateChanged = QtCore.Signal()
    rate = QtCore.Property(float, get_rate, set_rate, notify=rateChanged)

    n1Changed = QtCore.Signal()
    n1 = QtCore.Property(float, get_n1, set_n1, notify=n1Changed)

    n2Changed = QtCore.Signal()
    n2 = QtCore.Property(float, get_n2, set_n2, notify=n2Changed)

    sourceChanged = QtCore.Signal()
    source = QtCore.Property(str, get_source, set_source, notify=sourceChanged)

    quoteChanged = QtCore.Signal()
    quote = QtCore.Property(str, get_quote, set_quote, notify=quoteChanged)

    obj_idChanged = QtCore.Signal()
    obj_id = QtCore.Property(str, get_id, notify=obj_idChanged)


class BlocksModel(QtCore.QAbstractListModel):
    def __init__(self):
        super().__init__()
        self.blockItems = []

    def rowCount(self, parent=QtCore.QModelIndex()):
        return len(self.blockItems)

    def setData(self, index, value, role=QtCore.Qt.EditRole):
        if role == QtCore.Qt.EditRole:
            self.blockItems[index.row()] = value
            self.dataChanged.emit(index, index)
            return True
        return False

    def data(self, index, role=QtCore.Qt.DisplayRole):
        if role == QtCore.Qt.DisplayRole:
            row = index.row()
            if 0 <= row < self.rowCount():
                return self.blockItems[row]
        if role == QtCore.Qt.UserRole:
            row = index.row()
            return id(self.blockItems[row])

    @QtCore.Slot()
    def clear(self):
        self.beginRemoveRows(QtCore.QModelIndex(), 0, self.rowCount()-1)
        self.blockItems.clear()
        self.endRemoveRows()

    @QtCore.Slot()
    def append(self, block=CurrencyBlock()):
        self.beginInsertRows(QtCore.QModelIndex(), self.rowCount(), self.rowCount())
        self.blockItems.append(block)
        self.endInsertRows()

    @QtCore.Slot(str)
    def removeRow(self, obj_id, parent=QtCore.QModelIndex()):
        for row in range(0, self.rowCount()):
            if self.blockItems[row].get_id() == obj_id:
                self.beginRemoveRows(QtCore.QModelIndex(), row, row)
                self.blockItems.pop(row)
                self.endRemoveRows()
                return True
        return False

    def save(self):
        temp = []
        for block in self.blockItems:
            temp.append({"rate": block.rate, "n1": block.n1, "n2": block.n2, "source": block.source, "quote": block.quote})

        json.dump(temp, open("../saves/save.json", "w+"), indent=4)

    def load(self, fp):
        json_obj = json.load(fp)
        for json_block in json_obj:
            self.append(CurrencyBlock(rate=json_block["rate"], n1=json_block["n1"], n2=json_block["n2"], source=json_block["source"], quote=json_block["quote"]))


class CurrencyListModel(QtCore.QAbstractListModel):
    def __init__(self, currency_list):
        super().__init__()
        self.currency_list = []
        self.beginInsertRows(QtCore.QModelIndex(), 0, len(currency_list)-1)
        self.currency_list = currency_list
        self.endInsertRows()

    def rowCount(self, parent=QtCore.QModelIndex()):
        return len(self.currency_list)

    def data(self, index, role=QtCore.Qt.DisplayRole):
        if role == QtCore.Qt.DisplayRole:
            row = index.row()
            if 0 <= row < self.rowCount():
                return self.currency_list[row]
