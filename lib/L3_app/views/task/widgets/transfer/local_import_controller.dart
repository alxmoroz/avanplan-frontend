// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/usecases/task_comparators.dart';
import '../../../../../main.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_tree.dart';
import '../../controllers/task_controller.dart';

part 'local_import_controller.g.dart';

class LocalImportController extends _LocalImportControllerBase with _$LocalImportController {
  LocalImportController(Task _sourceGoal, TaskController _taskController) {
    taskController = _taskController;
    sourceGoal = _sourceGoal;
    srcTasks = sourceGoal.openedSubtasks.sorted(sortByDateAsc);
    checks = [for (var _ in srcTasks) false];
  }
}

abstract class _LocalImportControllerBase with Store {
  late final TaskController taskController;
  late final Task sourceGoal;
  late final List<Task> srcTasks;

  Task get destinationGoal => taskController.task;

  @observable
  List<bool> checks = [];

  @computed
  bool get validated => checks.contains(true);

  @computed
  bool get selectedAll => !checks.contains(false);

  @action
  void toggleSelectedAll(bool? value) => checks = [for (var _ in srcTasks) value == true];

  @action
  void selectTask(int index, bool? selected) {
    checks[index] = selected == true;
    checks = [...checks];
  }

  Future moveTasks() async {
    loader.start();
    loader.setSaving();

    int moved = 0;
    for (int index = 0; index < checks.length; index++) {
      if (checks[index]) {
        final t = srcTasks[index];
        t.parentId = destinationGoal.id;
        if (await taskUC.save(t) != null) {
          moved++;
        }
      }
    }

    if (moved > 0) {
      mainController.refresh();
      taskController.selectTab(TaskTabKey.subtasks);
    }

    Navigator.of(rootKey.currentContext!).pop();
    await loader.stop(300);
  }
}
