// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/status.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/ws_ext.dart';
import 'task_ext_actions.dart';

extension TaskRefsExt on Task {
  Status? get status => ws.statusForId(statusId);
}
