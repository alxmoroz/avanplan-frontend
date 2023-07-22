// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/status.dart';
import '../entities/task.dart';
import '../entities_extensions/task_level.dart';

extension TaskStatusExtension on Task {
  List<Status> get statuses {
    List<Status> res = [];
    if (!isRoot) {
      final pStatuses = project!.projectStatuses;
      if (pStatuses.isNotEmpty) {
        res = pStatuses.map((ps) => ws.statuses.firstWhere((s) => s.id == ps.statusId)).toList();
      } else {
        res = ws.statuses;
      }
    }

    return res;
  }

  Iterable<int> get _closedStatusIds => statuses.where((s) => s.closed == true).map((s) => s.id!);
  int? get firstClosedStatusId => _closedStatusIds.firstOrNull;

  Iterable<int> get _openedStatusIds => statuses.where((s) => s.closed == false).map((s) => s.id!);
  int? get firstOpenedStatusId => _openedStatusIds.firstOrNull;

  Status? statusForId(int? id) => statuses.firstWhereOrNull((s) => s.id == id);

  Status? get status => statusForId(statusId);
}
