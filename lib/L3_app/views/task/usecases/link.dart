// Copyright (c) 2024. Alexandr Moroz

import 'package:url_launcher/url_launcher_string.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/alert_dialog.dart';
import '../../../components/button.dart';
import '../../../extra/services.dart';
import '../../../navigation/router.dart';
import '../../../presenters/task_tree.dart';
import '../../../usecases/ws_actions.dart';
import '../controllers/task_controller.dart';
import 'edit.dart';

extension TaskLinkUC on Task {
  Future go2source() async => await launchUrlString(taskSource!.urlString);

  void unlinkTaskTree() {
    for (Task t in subtasks) {
      t.unlinkTaskTree();
    }
    taskSource?.keepConnection = false;
  }
}

extension LinkUC on TaskController {
  Future unlink() async {
    final confirm = await showMTAlertDialog(
      title: loc.tasksource_unlink_dialog_title,
      description: loc.tasksource_unlink_dialog_hint,
      actions: [
        MTDialogAction(title: loc.action_unlink_tasksource_title, type: ButtonType.danger, result: true),
        MTDialogAction(onTap: task.go2source, result: false),
      ],
    );

    if (confirm == true && await taskDescriptor.ws.checkBalance(loc.action_unlink_tasksource_title)) {
      router.pop();
      await editWrapper(() async {
        if (await taskUC.unlink(taskDescriptor)) {
          taskDescriptor.unlinkTaskTree();
        }
      });
    }
  }
}
