// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_dates.dart';
import '../../L1_domain/entities_extensions/task_type.dart';
import '../../L1_domain/entities_extensions/ws_tariff.dart';
import 'task_actions.dart';
import 'task_tree.dart';

extension TaskViewPresenter on Task {
  bool get hasAnalytics => ws.hfAnalytics && isProjectOrGoal;
  bool get hasFinance => ws.hfFinance && isProjectOrGoal;
  bool get hasTeam => canShowMembers && (members.isNotEmpty || canEditMembers);

  bool get canShowTimeChart => hasAnalytics && (hasDueDate || hasEtaDate);
  bool get canShowVelocityVolumeCharts => hasAnalytics;
}
