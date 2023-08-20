// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import 'task_tree.dart';

TaskState stateFromStr(String strState) => TaskState.values.firstWhereOrNull((s) => s.name == strState) ?? TaskState.NO_INFO;

extension TaskStats on Task {
  bool get projectLowStart => project!.state == TaskState.LOW_START;
  double? get projectVelocity => project!.velocity;
  double? get projectRequiredVelocity => project!.requiredVelocity;
  bool get projectHasProgress => project!.progress > 0;
}
