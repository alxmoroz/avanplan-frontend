// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../components/mt_field_data.dart';

part 'edit_controller.g.dart';

abstract class EditController = _EditControllerBase with _$EditController;

abstract class _EditControllerBase with Store {
  Map<int, TextEditingController> _teControllers = {};

  TextEditingController? teController(int code) => _teControllers[code];

  @mustCallSuper
  void initState({List<MTFieldData>? fds}) {
    _fdMap = ObservableMap.of({for (var fd in fds ?? <MTFieldData>[]) fd.code: fd});
    _teControllers = {for (var fd in _fdMap.values) fd.code: _makeTEController(fd.code)};
  }

  @mustCallSuper
  void dispose() {
    for (var c in _teControllers.values) {
      c.dispose();
    }
  }

  @observable
  ObservableMap<int, MTFieldData> _fdMap = ObservableMap();

  @action
  void _updateData(MTFieldData fd, TextEditingController te) {
    if (fd.text != te.text) {
      _fdMap[fd.code] = fd.copyWith(text: te.text);
    }
  }

  TextEditingController _makeTEController(int code) {
    final _fd = fData(code);
    final teController = TextEditingController(text: '$_fd');
    teController.addListener(() => _updateData(_fd, teController));
    return teController;
  }

  @computed
  Iterable<MTFieldData> get _fds => _fdMap.values;

  @computed
  Iterable<MTFieldData> get _validatableFD => _fds.where((fd) => fd.validate);

  @computed
  bool get filled => _validatableFD.every((fd) => fd.text.isNotEmpty);

  @computed
  bool get validated => filled && !_validatableFD.any((fd) => fd.errorText != null);

  MTFieldData fData(int code) => _fdMap[code]!;

  @action
  void updateField(int code, {bool? loading}) => _fdMap[code] = fData(code).copyWith(loading: loading);
}
