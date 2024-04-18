// Copyright (c) 2023. Alexandr Moroz

import 'package:url_launcher/url_launcher_string.dart';

import '../../L1_domain/entities/task.dart';
import '../extra/services.dart';
import '../usecases/ws_tariff.dart';
import 'task_edit.dart';
import 'task_tree.dart';

extension TaskLinkUC on Task {
  Future go2source() async => await launchUrlString(taskSource!.urlString);

  void unlinkTaskTree() {
    for (Task t in subtasks) {
      t.unlinkTaskTree();
    }
    taskSource?.keepConnection = false;
  }

  Future unlink() async {
    if (await ws.checkBalance(loc.task_unlink_action_title)) {
      await editWrapper(() async {
        if (await taskUC.unlink(this)) {
          unlinkTaskTree();
        }
        return this;
      });
    }
  }
}
