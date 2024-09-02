// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_dates.dart';
import '../../L1_domain/entities_extensions/task_type.dart';
import 'project_module.dart';
import 'task_actions.dart';

extension TaskViewPresenter on Task {
  bool get hasAnalytics => hmAnalytics && isProjectOrGoal;
  bool get hasFinance => hmFinance && isProjectOrGoal;
  bool get hasTeam => canShowMembers && (members.isNotEmpty || canEditMembers);

  bool get canShowTimeChart => hasAnalytics && (hasDueDate || hasEtaDate);
  bool get canShowVelocityVolumeCharts => hasAnalytics;
}
