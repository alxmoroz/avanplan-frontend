// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_dates.dart';
import '../../L1_domain/entities_extensions/task_type.dart';
import '../../L1_domain/entities_extensions/ws_tariff.dart';
import 'task_tree.dart';

extension TaskViewPresenter on Task {
  bool get hasAnalytics => isProjectOrGoal && ws.hfAnalytics;
  bool get hasFinance => isProjectOrGoal && ws.hfFinance;

  bool get canShowTimeChart => hasAnalytics && (hasDueDate || hasEtaDate);
  bool get canShowVelocityVolumeCharts => hasAnalytics;
}
