// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L3_app/presenters/task_tree.dart';
import '../entities/status.dart';
import '../entities/task.dart';

extension TaskStatus on Task {
  List<Status> get statuses {
    List<Status> res = [];

    final pStatuses = project?.projectStatuses ?? [];
    if (pStatuses.isNotEmpty) {
      res = pStatuses.map((ps) => ws.statuses.firstWhere((s) => s.id == ps.statusId)).toList();
    } else {
      res = ws.statuses;
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
        closedDate = DateTime.now();
      }
    }
  }
}
