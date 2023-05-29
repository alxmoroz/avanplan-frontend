// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/priority.dart';
import '../../L1_domain/entities/status.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/workspace.dart';
import '../extra/services.dart';

extension TaskRefsExt on Task {
  Workspace get ws => mainController.wsForId(wsId);

  Status? get status => ws.statuses.firstWhereOrNull((s) => s.id == statusId);
  Priority? get priority => ws.priorities.firstWhereOrNull((p) => p.id == priorityId);
}
