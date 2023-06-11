// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../components/text_field_annotation.dart';

part 'edit_controller.g.dart';

abstract class EditController = _EditControllerBase with _$EditController;

abstract class _EditControllerBase with Store {
  Map<String, TextEditingController> teControllers = {};

  @mustCallSuper
  void initState({List<TFAnnotation>? tfaList}) {
    tfAnnotations = ObservableMap.of({for (var tfa in tfaList ?? <TFAnnotation>[]) tfa.code: tfa});
    teControllers = {for (var tfa in tfAnnotations.values) tfa.code: _makeTEController(tfa.code)};
  }

  @mustCallSuper
  void dispose() {
    for (var c in teControllers.values) {
      c.dispose();
    }
  }

  @observable
  ObservableMap<String, TFAnnotation> tfAnnotations = ObservableMap();

  TextEditingController _makeTEController(String code) {
    final teController = TextEditingController(text: '${tfa(code)}');
    teController.addListener(() {
      final ta = tfa(code);
      if (ta.text != teController.text) {
        tfAnnotations[ta.code] = ta.copyWith(text: teController.text);
      }
    });
    return teController;
  }

  @computed
  Iterable<TFAnnotation> get _allTA => tfAnnotations.values;

  @computed
  Iterable<TFAnnotation> get _validatableTA => _allTA.where((ta) => ta.needValidate);

  @computed
  bool get filled => _validatableTA.every((ta) => ta.text.isNotEmpty);

  @computed
  bool get validated => filled && !_validatableTA.any((ta) => ta.errorText != null);

  TFAnnotation tfa(String code) => tfAnnotations[code]!;

  @action
  void updateTFA(String code, {bool? loading}) {
    final ta = tfa(code);
    tfAnnotations[code] = ta.copyWith(loading: loading);
  }
}
