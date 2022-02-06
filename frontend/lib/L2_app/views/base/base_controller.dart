// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../../../extra/services.dart';

part 'base_controller.g.dart';

class TFAnnotation {
  TFAnnotation(this.code, {this.text = '', this.label = ''});

  final String code;
  final String label;

  String text;
  bool edited = false;

  TFAnnotation copyWith({required String text}) => TFAnnotation(code, text: text, label: label)..edited = true;

  @override
  String toString() => text;

  String? get errorText {
    String? errText;
    if (!edited) {
      return null;
    }

    if (text.trim().isEmpty) {
      errText = loc.validation_empty_text;
    }
    return errText;
  }
}

class BaseController = _BaseControllerBase with _$BaseController;

abstract class _BaseControllerBase with Store {
  BuildContext? context;
  Map<String, TextEditingController> controllers = {};

  Future init() async => this;

  @mustCallSuper
  Future initState(BuildContext _context, {List<TFAnnotation>? tfaList}) async {
    context = _context;

    _tfAnnotations = ObservableMap.of({for (var tfa in tfaList ?? <TFAnnotation>[]) tfa.code: tfa});
    controllers = {for (var tfa in _tfAnnotations.values) tfa.code: makeController(tfa.code)};
  }

  @mustCallSuper
  void dispose() {
    for (var c in controllers.values) {
      c.dispose();
    }
  }

  @observable
  ObservableMap<String, TFAnnotation> _tfAnnotations = ObservableMap();

  TextEditingController makeController(String code) {
    final controller = TextEditingController(text: '${tfAnnoForCode(code)}');
    controller.addListener(() {
      final ta = tfAnnoForCode(code);
      if (ta.text != controller.text) {
        _tfAnnotations[ta.code] = ta.copyWith(text: controller.text);
      }
    });
    return controller;
  }

  @computed
  bool get validated => !_tfAnnotations.values.any((ta) => ta.errorText != null);

  TFAnnotation tfAnnoForCode(String code) => _tfAnnotations[code]!;
}
