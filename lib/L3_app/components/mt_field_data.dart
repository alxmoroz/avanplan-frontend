// Copyright (c) 2023. Alexandr Moroz

import '../extra/services.dart';

class MTFieldData {
  MTFieldData(
    this.code, {
    this.text = '',
    this.label = '',
    this.placeholder = '',
    this.helper,
    this.validator,
    this.needValidate = true,
    this.noText = false,
    this.loading = false,
  });

  final String code;
  final String label;
  final String placeholder;
  final String? helper;
  final String? Function(String)? validator;
  final bool needValidate;
  final bool noText;

  final bool loading;
  final String text;
  bool edited = false;

  MTFieldData copyWith({String? text, bool? loading}) => MTFieldData(
        code,
        text: text ?? this.text,
        loading: loading ?? this.loading,
        label: label,
        placeholder: placeholder,
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
