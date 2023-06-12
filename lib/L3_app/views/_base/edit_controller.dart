// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../components/mt_field_data.dart';

part 'edit_controller.g.dart';

abstract class EditController = _EditControllerBase with _$EditController;

abstract class _EditControllerBase with Store {
  Map<String, TextEditingController> teControllers = {};

  @mustCallSuper
  void initState({List<MTFieldData>? fds}) {
    _fdMap = ObservableMap.of({for (var fd in fds ?? <MTFieldData>[]) fd.code: fd});
    teControllers = {for (var fd in _fdMap.values) fd.code: _makeTEController(fd.code)};
  }

  @mustCallSuper
  void dispose() {
    for (var c in teControllers.values) {
      c.dispose();
    }
  }

  @observable
  ObservableMap<String, MTFieldData> _fdMap = ObservableMap();

  TextEditingController _makeTEController(String code) {
    final _f = fData(code);
    final teController = TextEditingController(text: '$_f');
    teController.addListener(() {
      if (_f.text != teController.text) {
        _fdMap[_f.code] = _f.copyWith(text: teController.text);
      }
    });
    return teController;
  }

  @computed
  Iterable<MTFieldData> get _fds => _fdMap.values;

  @computed
  Iterable<MTFieldData> get _validatableFD => _fds.where((fd) => fd.needValidate);

  @computed
  bool get filled => _validatableFD.every((fd) => fd.text.isNotEmpty);

  @computed
  bool get validated => filled && !_validatableFD.any((fd) => fd.errorText != null);

  MTFieldData fData(String code) => _fdMap[code]!;

  @action
  void updateField(String code, {bool? loading}) {
    final fd = fData(code);
    _fdMap[code] = fd.copyWith(loading: loading);
  }
}
