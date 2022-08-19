// Copyright (c) 2022. Alexandr Moroz

import 'task.dart';
import 'task_ext_level.dart';

extension TaskActionsExt on Task {
  /// доступные действия
  bool get canAdd => !closed;
  bool get canEdit => !isWorkspace;
  bool get canImport => isWorkspace;
  bool get canRefresh => isWorkspace;
}
