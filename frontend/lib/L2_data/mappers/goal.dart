// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/goal.dart';
import 'goal_report.dart';
import 'task.dart';

extension GoalMapper on GoalSchemaGet {
  Goal get goal => Goal(
        id: id,
        createdOn: createdOn.toLocal(),
        updatedOn: updatedOn.toLocal(),
        title: title,
        description: description ?? '',
        dueDate: dueDate?.toLocal(),
        report: report != null ? report!.report : null,
        tasks: tasks?.map((t) => t.task) ?? [],
      );
}
