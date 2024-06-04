// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../components/constants.dart';
import '../../../components/dialog.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_type.dart';
import '../../../usecases/task_tree.dart';
import '../controllers/task_controller.dart';
import '../widgets/text_fields/text_edit_dialog.dart';
import 'edit.dart';

extension TitleUC on TaskController {
  /// название
  String get titlePlaceholder => newSubtaskTitle(task.parent);

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

  Future editTitle(String str) async {
    if (titleEditTimer != null) {
      titleEditTimer!.cancel();
    }
    titleEditTimer = Timer(TEXT_SAVE_DELAY_DURATION, () async => await _setTitle(str));
  }

  void setTitleFocus() => focusNode(TaskFCode.title.index)?.requestFocus();

  Future editDescription() async {
    final fIndex = TaskFCode.description.index;
    final tc = teController(fIndex)!;
    final fdText = fData(fIndex).text;
    tc.text = fdText.isNotEmpty ? fdText : task.description;
    if (await showMTDialog<bool?>(TextEditDialog(this, TaskFCode.description, loc.description), maxWidth: SCR_M_WIDTH) == true) {
      final newValue = tc.text.trim();
      final oldValue = task.description;

      if (task.description != newValue) {
        updateField(fIndex, loading: true, text: '');
        task.description = newValue;
        if (!(await saveField(TaskFCode.description))) {
          task.description = oldValue;
        }
        updateField(fIndex, loading: false);
      }
    }
  }
}
