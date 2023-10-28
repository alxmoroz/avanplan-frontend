// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_stats.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../components/colors_base.dart';
import '../usecases/task_actions.dart';
import '../usecases/task_feature_sets.dart';
import 'task_state.dart';

extension TaskViewPresenter on Task {
  Color get bgColor => b2Color;

  bool get canShowTimeChart => hfsAnalytics && isOpenedGroup && (hasDueDate || hasEtaDate);
  bool get canShowVelocityVolumeCharts => hfsAnalytics && !needUserActionState && isOpenedGroup;
  bool get canShowChartDetails => canShowVelocityVolumeCharts || canShowTimeChart;

  bool get hasOverviewPane => hfsAnalytics && isOpenedGroup;
  bool get hasTeamPane => canViewMembers && (members.isNotEmpty || canEditMembers);
}
