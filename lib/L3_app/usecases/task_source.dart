// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/ws_sources.dart';
import 'task_tree.dart';

extension TaskSourceUC on Task {
  Source? get source => ws.sourceForId(taskSource?.sourceId);
}
