// Copyright (c) 2022. Alexandr Moroz

import '../extra/services.dart';

// TODO: почему нельзя использовать MTTextField для этих целей? Или убрать эту прослойку или объяснить зачем она

class TFAnnotation {
  TFAnnotation(
    this.code, {
    this.text = '',
    this.label = '',
    this.helper,
    this.validator,
    this.needValidate = true,
    this.noText = false,
  });

  final String code;
  final String label;
  final String? helper;
  final String? Function(String)? validator;
  final bool needValidate;
  final bool noText;

  String text;
  bool edited = false;

  TFAnnotation copyWith({required String text}) => TFAnnotation(
        code,
        text: text,
        label: label,
        helper: helper,
        validator: validator,
        needValidate: needValidate,
        noText: noText,
      )..edited = true;

  @override
  String toString() => text;

  String? emptyValidator(String text) {
    return text.trim().isEmpty ? loc.validation_empty_text : null;
  }

  String? get errorText {
    if (!edited || !needValidate) {
      return null;
    }

    return validator != null ? validator!(text) : emptyValidator(text);
  }
}
