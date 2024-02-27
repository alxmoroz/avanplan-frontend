// Copyright (c) 2024. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import 'task_tree.dart';

extension TaskStats on Task {
  bool get projectLowStart => project!.state == TaskState.LOW_START;
  double? get projectVelocity => project!.velocity;
}
