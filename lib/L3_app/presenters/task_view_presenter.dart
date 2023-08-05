// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_stats.dart';
import '../usecases/task_ext_actions.dart';
import 'task_state_presenter.dart';

extension TaskViewPresenter on Task {
  bool get canShowTimeChart => canShowState && (hasDueDate || hasEtaDate);
  bool get canShowVelocityVolumeCharts => !canShowRecommendsEta && canShowState;
  bool get canShowChartDetails => canShowVelocityVolumeCharts || canShowTimeChart;

  bool get hasOverviewPane => canShowState || canShowTimeChart || canShowVelocityVolumeCharts;
  bool get hasTeamPane => canMembersRead && (members.isNotEmpty || canEditMembers);
}
