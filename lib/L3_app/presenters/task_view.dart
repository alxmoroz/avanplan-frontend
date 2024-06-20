// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_stats.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../usecases/project_module.dart';
import '../usecases/task_actions.dart';

extension TaskViewPresenter on Task {
  bool get hasAnalytics => hmAnalytics && isProjectOrGoal;
  bool get hasTeam => canShowMembers && (members.isNotEmpty || canEditMembers);

  bool get canShowTimeChart => hasAnalytics && (hasDueDate || hasEtaDate);
  bool get canShowVelocityVolumeCharts => hasAnalytics;
}
