// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/services.dart';

class LeadingZeroesInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(RegExp(r'0\d+'))) {
      newValue = TextEditingValue(
        text: newValue.text.replaceFirst(RegExp(r'0'), ''),
        composing: TextRange.empty,
      );
    }

    return newValue;
  }
}
