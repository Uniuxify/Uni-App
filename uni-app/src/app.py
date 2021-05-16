import coingate as cg_api
from PySide6 import QtCore


class CurrencyBlock(QtCore.QObject):
    def __init__(self, n1=1, n2=1, rate=1, source="UNI", quote="UNI"):
        super().__init__()
        self.__n1 = n1
        self.__n2 = n2
        self.__rate = rate
        self.source = source
        self.quote = quote
        self.reversed = False  # n1 соответсвует source, n2 соответсвует quote

    @QtCore.Slot
    def update_rate(self):
        self.rate = cg_api.get_rate(self.source, self.quote)

    def get_rate(self):
        return self.__rate

    def set_rate(self, rate):
        self.__rate = rate
        self.update_n1()

    def update_n1(self):
        if not self.reversed:
            self.n1 = self.n2 / self.rate
        else:
            self.n1 = self.n2 * self.rate

    def get_n1(self):
        return self.__n1

    def set_n1(self, n1):
        self.__n1 = n1
        self.update_n2()

    def update_n2(self):
        if not self.reversed:
            self.n2 = self.n1 * self.rate
        else:
            self.n2 = self.n1 / self.rate

    def get_n2(self):
        return self.__n2

    def set_n2(self, n2):
        self.__n2 = n2
        self.update_n1()

    def swap(self):
        self.reversed = not self.reversed

    rate = property(get_rate, set_rate)
    n1 = property(get_n1, set_n1)
    n2 = property(get_n2, set_n2)


class BlocksModel(QtCore.QAbstractListModel):
    def __init__(self):
        super().__init__()
        self.blockItems = []

    def rowCount(self, parent=QtCore.QModelIndex()):
        return len(self.blockItems)

    def setData(self, index, value, role=QtCore.Qt.EditRole):
        if role == QtCore.Qt.EditRole:
            self.m_items[index.row()] = str(value.toString())
            self.dataChanged.emit(index, index)
            return True
        return False

    def data(self, index, role=QtCore.Qt.DisplayRole):
        if role == QtCore.Qt.DisplayRole:
            row = index.row()
            if 0 <= row < self.rowCount():
                return self.blockItems[row]


class App:

    def __init__(self):
        self.blocks = []

    def clear(self):
        self.blocks.clear()

    def add(self):
        self.blocks.append(CurrencyBlock())

    # TODO
    def load_from_json(self, path):
        pass
