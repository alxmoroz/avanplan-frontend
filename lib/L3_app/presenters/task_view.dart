// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_stats.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../components/colors_base.dart';
import '../usecases/task_actions.dart';
import 'task_state.dart';

extension TaskViewPresenter on Task {
  Color get bgColor => b2Color;

  bool get canShowTimeChart => isOpenedGroup && (hasDueDate || hasEtaDate);
  bool get canShowVelocityVolumeCharts => !canShowRecommendsEta && isOpenedGroup;
  bool get canShowChartDetails => canShowVelocityVolumeCharts || canShowTimeChart;

  bool get hasOverviewPane => isOpenedGroup || canShowTimeChart || canShowVelocityVolumeCharts;
  bool get hasTeamPane => canViewMembers && (members.isNotEmpty || canEditMembers);
}
