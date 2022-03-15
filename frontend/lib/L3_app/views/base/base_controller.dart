// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import 'tf_annotation.dart';

part 'base_controller.g.dart';

class BaseController = _BaseControllerBase with _$BaseController;

abstract class _BaseControllerBase with Store {
  BuildContext? context;
  Map<String, TextEditingController> controllers = {};

  Future init() async => this;

  @mustCallSuper
  void initState(BuildContext _context, {List<TFAnnotation>? tfaList}) {
    context = _context;
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
  bool get validated => !tfAnnotations.values.any((ta) => ta.errorText != null || !ta.edited);

  TFAnnotation tfAnnoForCode(String code) => tfAnnotations[code]!;

  @observable
  bool editMode = false;

  @action
  void setEditMode(bool mode) => editMode = mode;
}
