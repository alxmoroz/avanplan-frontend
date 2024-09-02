// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_type.dart';
import '../presenters/workspace.dart';
import 'task_tree.dart';

extension TaskEstimatePresenter on Task {
  String get estimateStr => '${(isTask ? estimate : openedVolume)?.round()} ${ws.estimateUnitCode}';
}
