// Copyright (c) 2025. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_local_settings.dart';
import '../../L1_domain/entities/task_settings.dart';
import '../../L1_domain/entities_extensions/task_type.dart';
import 'task_tree.dart';

extension TaskSettingsExt on Task {
  TaskViewMode get _defProjectEffectiveViewMode {
    TaskViewMode defProjectViewMode = TaskViewMode.fromString(
      settings.firstWhereOrNull((s) => s.code == TSCode.VIEW_MODE)?.value,
    );

    // TODO: deprecated как только не останется версий < 2.10
    // Есть цели или бэклоги, то это вид проекта
    if (hasSubgroups) {
      defProjectViewMode = TaskViewMode.PROJECT;
    }
    // Есть задачи, то это список или доска. Но если с бэка приходит PROJECT, то переопределяем как доска
    else if (hasSubtasks && defProjectViewMode.isProject) {
      defProjectViewMode = TaskViewMode.BOARD;
    }
    return defProjectViewMode;
  }

  TaskViewMode get defaultProjectViewMode {
    return isInbox ? TaskViewMode.LIST : _defProjectEffectiveViewMode;
  }
}
