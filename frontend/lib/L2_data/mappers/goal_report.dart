// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/goal_report.dart';

extension GoalMapper on GoalReportSchema {
  GoalReport get report => GoalReport(
        etaDate: etaDate?.toLocal(),
        factSpeed: factSpeed ?? 0,
        planSpeed: planSpeed ?? 0,
      );
}
