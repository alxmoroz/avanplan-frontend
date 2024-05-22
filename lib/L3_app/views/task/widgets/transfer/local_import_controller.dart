// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/dialog.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/edit.dart';
import 'transfer_selector.dart';
import 'transfer_selector_controller.dart';

part 'local_import_controller.g.dart';

class LocalImportController extends _LocalImportControllerBase with _$LocalImportController {
  LocalImportController(TaskController taskController) {
    _taskController = taskController;
  }
}

abstract class _LocalImportControllerBase with Store {
  late final TaskController _taskController;

  Task get dstGroup => _taskController.task;

  @observable
  Task? srcGroup;

  @computed
  bool get srcGroupSelected => srcGroup != null;

  @action
  void _setSrc(Task src) {
    srcGroup = src;
    srcTasks = srcGroup?.openedSubtasks.sorted((t1, t2) => t1.compareTo(t2)) ?? [];
    checks = ObservableList.of([for (var _ in srcTasks) false]);
  }

  @observable
  List<Task> srcTasks = [];

  @observable
  ObservableList<bool> checks = ObservableList();

  @computed
  bool get validated => checks.contains(true);

  @computed
  bool get selectedAll => !checks.contains(false);

  @action
  void toggleAll(bool? value) => checks = ObservableList.of([for (var _ in srcTasks) value == true]);

  @action
  void checkTask(int index, bool? selected) => checks[index] = selected == true;

  Future selectSourceForMove() async {
    final controller = TransferSelectorController();
    controller.getSourcesForMove(dstGroup);
    final srcGoal = await showMTDialog<Task>(TransferSelectorDialog(
      controller,
      loc.task_transfer_source_hint,
      loc.task_transfer_import_empty_title,
    ));
    if (srcGoal != null) {
      _setSrc(srcGoal);
    }
  }

  Future moveTasks(BuildContext context) async {
    context.pop();
    final dstParentId = dstGroup.id;
    for (int index = 0; index < checks.length; index++) {
      if (checks[index]) {
        final t = srcTasks[index];
        t.parentId = dstParentId;
        await TaskController(taskIn: t).save();
      }
    }
  }
}
