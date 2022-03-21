// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../components/text_field_annotation.dart';

part 'base_controller.g.dart';

class BaseController = _BaseControllerBase with _$BaseController;

abstract class _BaseControllerBase with Store {
  Map<String, TextEditingController> controllers = {};

  Future init() async => this;

  @mustCallSuper
  void initState({List<TFAnnotation>? tfaList}) {
    tfAnnotations = ObservableMap.of({for (var tfa in tfaList ?? <TFAnnotation>[]) tfa.code: tfa});
    controllers = {for (var tfa in tfAnnotations.values) tfa.code: makeController(tfa.code)};
  }

  @mustCallSuper
  void dispose() {
    for (var c in controllers.values) {
      c.dispose();
    }
  }

  @observable
  ObservableMap<String, TFAnnotation> tfAnnotations = ObservableMap();

  TextEditingController makeController(String code) {
    final controller = TextEditingController(text: '${tfAnnoForCode(code)}');
    controller.addListener(() {
      final ta = tfAnnoForCode(code);
      if (ta.text != controller.text) {
        tfAnnotations[ta.code] = ta.copyWith(text: controller.text);
      }
    });
    return controller;
  }

  @computed
  Iterable<TFAnnotation> get _allTA => tfAnnotations.values;

  @computed
  Iterable<TFAnnotation> get _validatableTA => _allTA.where((ta) => ta.needValidate);

  @computed
  bool get allNeedFieldsTouched => !_validatableTA.any((ta) => !ta.edited);

  @computed
  bool get anyFieldTouched => _allTA.any((ta) => ta.edited);

  @computed
  bool get validated => !_validatableTA.any((ta) => ta.errorText != null) && allNeedFieldsTouched;

  TFAnnotation tfAnnoForCode(String code) => tfAnnotations[code]!;
}
