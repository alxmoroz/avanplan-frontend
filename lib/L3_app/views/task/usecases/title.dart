// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../components/constants.dart';
import '../../../presenters/task_type.dart';
import '../controllers/task_controller.dart';
import 'edit.dart';

extension TitleUC on TaskController {
  void setFocus(int index) => focusNode(index)?.requestFocus();

  Future _setTitle(String str) async {
    final t = task;
    str = str.trim();
    final oldValue = t.title;
    if (oldValue != str) {
      if (str.isEmpty) {
        str = t.defaultTitle;
      }
      t.title = str;
      if (!(await saveField(TaskFCode.title))) {
        t.title = oldValue;
      }
    }
  }

  Future _setDescription(String str) async {
    final t = task;
    final newValue = str.trim();
    final oldValue = t.description;

    if (oldValue != newValue) {
      t.description = newValue;
      if (!(await saveField(TaskFCode.description))) {
        t.description = oldValue;
      }
    }
  }

  void _editTextWrapper(String str, Function(String str) setTextCallback) {
    if (textEditTimer != null) {
      textEditTimer!.cancel();
    }
    textEditTimer = Timer(TEXT_SAVE_DELAY_DURATION, () => setTextCallback(str));
  }

  void setTitle(String str) => _editTextWrapper(str, _setTitle);

  void setDescription(String str) => _editTextWrapper(str, _setDescription);
}
