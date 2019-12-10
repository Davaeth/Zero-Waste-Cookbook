class AdministratorAction {
  List<int> _indexes;
  List<int> get getIndexes => _indexes;
  set setIndexes(List<int> newIndexes) {
    _indexes = newIndexes;
  }

  bool _areReadyToDelete;
  bool get areReadyToDelete => _areReadyToDelete;
  set setReadyToDelete(bool areReady) {
    _areReadyToDelete = areReady;
  }

  AdministratorAction() {
    _indexes = List<int>();
    _areReadyToDelete = false;
  }

  multipleSelect(int index, Function callback) {
    if (_indexes.contains(index)) {
      _indexes.remove(index);
    } else {
      _indexes.add(index);
    }

    _areReadyToDelete = _indexes.length >= 1 ? true : false;

    callback();
  }
}
