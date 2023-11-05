// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import 'task_tree.dart';

extension TaskTransferPresenter on Task {
  // TODO: запрос на бэк
  Iterable<Task> get goalsForLocalExport => isTask ? project!.openedSubtasks.where((g) => g.id != parentId) : [];
  Iterable<Task> get goalsForLocalImport => (isGoal || isBacklog) ? project!.openedSubtasks.where((g) => g.id != id && g.hasOpenedSubtasks) : [];
}
