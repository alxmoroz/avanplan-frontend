// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/constants.dart';
import '../../../components/dialog.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_type.dart';
import '../../../usecases/task_tree.dart';
import '../widgets/text_fields/text_edit_dialog.dart';
import 'task_controller.dart';

class TitleController {
  TitleController(this._taskController);
  final TaskController _taskController;

  Task get task => _taskController.task;

  /// название
  String get titlePlaceholder => newSubtaskTitle(task.parent);

  Future _setTitle(String str) async {
    str = str.trim();
    if (task.title != str) {
      if (str.isEmpty) {
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
    final fIndex = TaskFCode.description.index;
    final tc = _taskController.teController(fIndex)!;
    final fdText = _taskController.fData(fIndex).text;
    tc.text = fdText.isNotEmpty ? fdText : task.description;
    if (await showMTDialog<bool?>(TextEditDialog(_taskController, TaskFCode.description, loc.description), maxWidth: SCR_M_WIDTH) == true) {
      final newValue = tc.text.trim();
      final oldValue = task.description;

      if (newValue.isNotEmpty && (task.description != newValue || _taskController.creating)) {
        _taskController.updateField(fIndex, loading: true, text: '');
        task.description = newValue;
        if (!(await _taskController.saveField(TaskFCode.description))) {
          task.description = oldValue;
        }
        _taskController.updateField(fIndex, loading: false);
      }
    }
  }
}
