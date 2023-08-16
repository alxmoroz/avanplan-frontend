// Copyright (c) 2023. Alexandr Moroz

import 'package:url_launcher/url_launcher_string.dart';

import '../../L1_domain/entities/task.dart';
import '../components/icons.dart';
import '../components/mt_alert_dialog.dart';
import '../extra/services.dart';
import '../presenters/source_presenter.dart';
import '../presenters/task_filter.dart';
import '../presenters/task_stats.dart';
import '../presenters/task_tree.dart';
import '../usecases/ws_tariff.dart';
import 'task_available_actions.dart';

extension TaskLink on Task {
  Future go2source() async => await launchUrlString(taskSource!.urlString);

  // TODO: нужно делать на бэке
  void unlinkTaskTree() {
    for (Task t in subtasks) {
      t.unlinkTaskTree();
    }
    if (linked) {
      taskSource?.keepConnection = false;
    }
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
    if (canUnlink) {
      if (await _unlinkDialog() == true) {
        loader.start();
        loader.setUnlinking();
        try {
          await importUC.unlinkTaskSources(ws, id!, allTaskSources());
          unlinkTaskTree();
          mainController.refresh();
        } catch (_) {}
        await loader.stop();
      }
    } else {
      await ws.changeTariff(reason: loc.tariff_change_limit_unlink_reason_title);
    }
  }
}
