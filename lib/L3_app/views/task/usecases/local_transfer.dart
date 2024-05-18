// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_feature_sets.dart';
import '../../../usecases/task_tree.dart';
import '../controllers/task_controller.dart';
import '../widgets/local_transfer/task_selector.dart';
import 'edit.dart';

extension LocalTransferUC on TaskController {
  /// перенос из других целей
  // TODO: можно дополнить переносом из инбокса и других проектов / целей - возможно, нет ещё такой задачи в бэклоге
  Iterable<Task> get targetsForLocalImport {
    final project = task.project;
    final isGoal = task.isGoal;
    final isBacklog = task.isBacklog;

    return (isGoal || isBacklog) ? project.openedSubtasks.where((g) => g.id != task.id && g.hasOpenedSubtasks) : [];
  }

  /// перенос в другую цель, проект

  List<Task> get _targetsForLocalExport {
    List<Task> targets = [];
    final project = task.project;
    final isTask = task.isTask;
    final isGoal = task.isGoal;
    final isBacklog = task.isBacklog;

    // в текущем проекте можно переносить задачи между целями
    if (isTask && task.hfsGoals) {
      targets = project.openedSubtasks.where((g) => g.id != task.parentId).toList();
    }

    // если есть соседние проекты
    for (final p in tasksMainController.openedProjects.where((p) => p.id != project.id)) {
      // если включены цели проекта, то можно переносить только задачу в эти цели или цель в корень проекта
      if (p.hfsGoals) {
        if (isTask) {
          targets.addAll(p.openedSubtasks);
        } else if (isGoal || isBacklog) {
          targets.add(p);
        }
      }
      // иначе, если цели выключены, то можно переносить только задачи в корень проекта
      else if (isTask) {
        targets.add(p);
      }
    }
    return targets;
  }

  Future localExport() async {
    final sourceTaskId = task.parentId;
    final destination = await selectTask(
      _targetsForLocalExport,
      loc.task_transfer_destination_hint,
    );

    if (destination != null) {
      // Перенос между проектами или РП
      if (destination.project.id != task.project.id || destination.wsId != task.wsId) {
        router.pop();

        await move(destination);
      }
      // внутри одного проекта
      else {
        // новый родитель
        task.parentId = destination.id;
        if (!await saveField(TaskFCode.parent)) {
          task.parentId = sourceTaskId;
          tasksMainController.refreshTasksUI();
        }
      }
    }
  }
}
