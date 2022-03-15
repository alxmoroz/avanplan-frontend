// Copyright (c) 2022. Alexandr Moroz

import '../../extra/services.dart';

class TFAnnotation {
  TFAnnotation(this.code, {this.text = '', this.label = '', this.validator, this.needValidate = true});

  final String code;
  final String label;
  final String? Function(String)? validator;
  final bool needValidate;

  String text;
  bool edited = false;

  TFAnnotation copyWith({required String text}) => TFAnnotation(
        code,
        text: text,
        label: label,
        validator: validator,
        needValidate: needValidate,
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
