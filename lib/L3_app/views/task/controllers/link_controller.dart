// Copyright (c) 2023. Alexandr Moroz

import '../../../../L1_domain/entities/task.dart';
import '../../../components/alert_dialog.dart';
import '../../../components/icons.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_source.dart';
import '../../../usecases/task_link.dart';
import 'task_controller.dart';

class LinkController {
  LinkController(this._taskController);
  final TaskController _taskController;
  Task get _task => _taskController.task;

  Future unlink() async {
    final confirm = await showMTAlertDialog(
      loc.task_unlink_dialog_title,
      description: loc.task_unlink_dialog_description,
      actions: [
        MTADialogAction(
          title: loc.task_unlink_action_title,
          type: MTActionType.isWarning,
          result: true,
          icon: const LinkBreakIcon(),
        ),
        MTADialogAction(
          type: MTActionType.isDefault,
          onTap: _task.go2source,
          result: false,
          child: _task.go2SourceTitle,
        ),
      ],
    );

    if (confirm == true) {
      _task.unlink();
      router.pop();
    }
  }
}
