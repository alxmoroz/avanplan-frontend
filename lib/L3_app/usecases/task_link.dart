// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../L1_domain/entities/task.dart';
import '../../main.dart';
import '../components/icons.dart';
import '../components/mt_alert_dialog.dart';
import '../extra/services.dart';
import '../presenters/task_source.dart';
import '../presenters/task_tree.dart';
import 'task_edit.dart';

extension TaskLink on Task {
  Future go2source() async => await launchUrlString(taskSource!.urlString);

  void unlinkTaskTree() {
    for (Task t in subtasks) {
      t.unlinkTaskTree();
    }
    taskSource?.keepConnection = false;
  }

  Future<bool?> _unlinkDialog() async => await showMTAlertDialog(
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
            onTap: go2source,
            result: false,
            child: go2SourceTitle,
          ),
        ],
      );

  Future unlink() async {
    if (await _unlinkDialog() == true) {
      Navigator.of(rootKey.currentContext!).pop();

      await edit(() async {
        if (await importUC.unlinkProject(this)) {
          unlinkTaskTree();
        }
        return this;
      });
    }
  }
}
