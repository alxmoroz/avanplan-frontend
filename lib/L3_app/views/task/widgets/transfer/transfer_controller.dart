// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../main.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_comparators.dart';
import '../../../../usecases/task_ext_actions.dart';
import '../../task_view_controller.dart';

part 'transfer_controller.g.dart';

class TransferController extends _TransferControllerBase with _$TransferController {
  TransferController(Task _sourceGoal, TaskViewController _taskController) {
    taskController = _taskController;
    sourceGoal = _sourceGoal;
    srcTasks = sourceGoal.openedSubtasks.sorted(sortByDateAsc);
    checks = [for (var _ in srcTasks) false];
  }
}

abstract class _TransferControllerBase with Store {
  late final TaskViewController taskController;
  late final Task sourceGoal;
  late final List<Task> srcTasks;

  Task get destinationGoal => taskController.task;

  @observable
  List<bool> checks = [];

  @computed
  bool get validated => checks.contains(true);

  @observable
  bool selectedAll = false;

  @action
  void toggleSelectedAll(bool? value) {
    selectedAll = !selectedAll;
    checks = [for (var _ in srcTasks) selectedAll];
  }

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
        t.parent = destinationGoal;
        if (await taskUC.save(t) != null) {
          sourceGoal.tasks.removeWhere((srcT) => srcT.id == t.id);
          destinationGoal.tasks.add(t);
          moved++;
        }
      }
    }

    if (moved > 0) {
      destinationGoal.updateParents();
      sourceGoal.updateParents();
      mainController.updateRootTask();
      taskController.selectTab(TaskTabKey.subtasks);
    }

    Navigator.of(rootKey.currentContext!).pop();
    await loader.stop(300);
  }
}
