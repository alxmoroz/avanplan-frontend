// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/usecases/task_comparators.dart';
import '../../../../../main.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_transfer.dart';
import '../../../../usecases/task_edit.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import 'task_selector.dart';

part 'local_import_controller.g.dart';

class LocalImportController extends _LocalImportControllerBase with _$LocalImportController {
  LocalImportController(TaskController taskController) {
    _taskController = taskController;
  }
}

abstract class _LocalImportControllerBase with Store {
  late final TaskController _taskController;

  Task get destinationGoal => _taskController.task!;

  @observable
  Task? sourceGoal;

  @computed
  bool get sourceSelected => sourceGoal != null;

  @action
  void _setSrc(Task src) {
    sourceGoal = src;
    srcTasks = sourceGoal?.openedSubtasks.sorted(sortByDateAsc) ?? [];
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

  Future selectSourceGoal() async {
    final srcGoal = await selectTask(destinationGoal.goalsForLocalImport.sorted(sortByDateAsc), loc.task_transfer_source_hint);
    if (srcGoal != null) {
      _setSrc(srcGoal);
    }
  }

  Future moveTasks() async {
    Navigator.of(rootKey.currentContext!).pop();
    final dstParentId = destinationGoal.id;
    for (int index = 0; index < checks.length; index++) {
      if (checks[index]) {
        final t = srcTasks[index];
        t.parentId = dstParentId;
        await t.save();
      }
    }
  }
}
