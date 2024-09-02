// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../components/constants.dart';
import '../../../presenters/task_tree.dart';
import '../../../presenters/task_type.dart';
import '../controllers/task_controller.dart';
import 'edit.dart';

extension TitleUC on TaskController {
  /// название
  String get titlePlaceholder => newSubtaskTitle(task.parent);

  void setFocus(int index) => focusNode(index)?.requestFocus();

  Future _setTitle(String str) async {
    str = str.trim();
    final oldValue = task.title;
    if (oldValue != str) {
      if (str.isEmpty) {
        str = titlePlaceholder;
      }
      task.title = str;
      if (!(await saveField(TaskFCode.title))) {
        task.title = oldValue;
      }
    }
  }

  Future _setDescription(String str) async {
    final newValue = str.trim();
    final oldValue = task.description;

    if (task.description != newValue) {
      task.description = newValue;
      if (!(await saveField(TaskFCode.description))) {
        task.description = oldValue;
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
