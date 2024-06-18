// Copyright (c) 2024. Alexandr Moroz

import 'package:url_launcher/url_launcher_string.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/alert_dialog.dart';
import '../../../components/icons.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_source.dart';
import '../../../usecases/task_tree.dart';
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
      loc.task_unlink_dialog_title,
      description: loc.task_unlink_dialog_description,
      actions: [
        MTADialogAction(
          title: loc.task_unlink_action_title,
          type: MTDialogActionType.warning,
          result: true,
          icon: const LinkBreakIcon(),
        ),
        MTADialogAction(
          type: MTDialogActionType.isDefault,
          onTap: task.go2source,
          result: false,
          child: task.go2SourceTitle,
        ),
      ],
    );

    if (confirm == true && await taskDescriptor.ws.checkBalance(loc.task_unlink_action_title)) {
      router.pop();
      await editWrapper(() async {
        if (await taskUC.unlink(taskDescriptor)) {
          taskDescriptor.unlinkTaskTree();
        }
      });
    }
  }
}
