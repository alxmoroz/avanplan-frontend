// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/goal_status.dart';

extension GoalStatusMapper on GoalStatusSchemaGet {
  GoalStatus get status => GoalStatus(
        id: id,
        title: title,
        closed: closed,
      );
}
