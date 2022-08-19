// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import 'task_level_presenter.dart';

extension TaskActionsPresenter on Task {
  /// доступные действия
  bool get canAdd => !closed;
  bool get canEdit => !isWorkspace;
  bool get canImport => isWorkspace;
  bool get canRefresh => isWorkspace;
}
