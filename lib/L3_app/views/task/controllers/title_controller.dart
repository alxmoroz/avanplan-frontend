// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/constants.dart';
import '../../../components/dialog.dart';
import '../../../presenters/task_tree.dart';
import '../../../presenters/task_type.dart';
import '../widgets/header/task_description_dialog.dart';
import 'task_controller.dart';

class TitleController {
  TitleController(this._taskController);
  final TaskController _taskController;

  Task get task => _taskController.task;

  /// название
  String get titlePlaceholder => newSubtaskTitle(task.parent);

  Future _setTitle(String str) async {
    if (task.title != str) {
      if (str.trim().isEmpty) {
        str = titlePlaceholder;
      }
      final oldValue = task.title;
      task.title = str;
      if (!(await _taskController.saveField(TaskFCode.title))) {
        task.title = oldValue;
      }
    }
  }

  Timer? _titleEditTimer;

  Future editTitle(String str) async {
    if (_titleEditTimer != null) {
      _titleEditTimer!.cancel();
    }
    _titleEditTimer = Timer(const Duration(milliseconds: 1000), () async => await _setTitle(str));
  }

  /// описание

  Future editDescription() async {
    final tc = _taskController.teController(TaskFCode.description.index);
    if (tc != null) {
      await showMTDialog<void>(TaskDescriptionDialog(tc), maxWidth: SCR_M_WIDTH);
      final newValue = tc.text;
      if (task.description != newValue) {
        final oldValue = task.description;
        task.description = newValue;
        if (!(await _taskController.saveField(TaskFCode.description))) {
          task.description = oldValue;
        }
      }
    }
  }
}
