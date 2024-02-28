// Copyright (c) 2024. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../extra/services.dart';
import '../usecases/task_feature_sets.dart';
import '../usecases/task_tree.dart';

extension TaskTransferPresenter on Task {
  List<Task> get targetsForLocalExport {
    List<Task> targets = [];
    // в текущем проекте можно переносить задачи между целями
    if (isTask && hfsGoals) {
      targets = project!.openedSubtasks.where((g) => g.id != parentId).toList();
    }

    // если есть соседние проекты
    for (final p in tasksMainController.openedProjects.where((p) => p.id != project?.id)) {
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

  // TODO: можно доделать перенос из инбокса и других проектов / целей
  Iterable<Task> get goalsForLocalImport => (isGoal || isBacklog) ? project!.openedSubtasks.where((g) => g.id != id && g.hasOpenedSubtasks) : [];
}
