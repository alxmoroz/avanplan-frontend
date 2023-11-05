// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/status.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/utils/dates.dart';
import '../usecases/ws_statuses.dart';
import 'task_tree.dart';

extension TaskStatus on Task {
  Iterable<Status> get statuses {
    List<Status> res = [];

    final pStatuses = project?.projectStatuses ?? [];
    if (pStatuses.isNotEmpty) {
      pStatuses.forEach((ps) {
        final s = ws.status(ps.statusId);
        if (s != null) {
          res.add(s);
        }
      });
    } else {
      res = ws.statuses.toList();
    }

    return res;
  }

  Iterable<int> get _closedStatusIds => statuses.where((s) => s.closed == true).map((s) => s.id!);
  int? get firstClosedStatusId => _closedStatusIds.firstOrNull;

  Iterable<int> get _openedStatusIds => statuses.where((s) => s.closed == false).map((s) => s.id!);
  int? get firstOpenedStatusId => _openedStatusIds.firstOrNull;

  Status? statusForId(int? id) => statuses.firstWhereOrNull((s) => s.id == id);

  Status? get status => statusForId(statusId);

  void setClosed(bool? close) {
    if (close != null) {
      closed = close;
      // TODO: на бэке нужна эта обработка, чтобы не было косяков из-за неправильно настроенных часов у клиента.
      // TODO: проверить выставление времени на фронте вообще. Не должно быть такого
      if (close) {
        closedDate = now;
      }
    }
  }
}
