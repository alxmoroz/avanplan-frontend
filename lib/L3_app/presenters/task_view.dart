// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_dates.dart';
import '../../L1_domain/entities_extensions/task_type.dart';
import '../../L1_domain/entities_extensions/ws_tariff.dart';
import 'task_tree.dart';

extension TaskViewPresenter on Task {
  bool get hasGroupAnalytics => isProjectOrGoal && ws.hfAnalytics;
  bool get hasGroupFinance => isProjectOrGoal && ws.hfFinance;

  bool get canShowTimeChart => hasGroupAnalytics && (hasDueDate || hasEtaDate);
  bool get canShowVelocityVolumeCharts => hasGroupAnalytics;
}
