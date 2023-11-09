// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/project_status.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/utils/dates.dart';
import 'task_tree.dart';

extension TaskStatus on Task {
  Iterable<ProjectStatus> get statuses => project?.projectStatuses ?? [];

  Iterable<int> get _closedStatusIds => statuses.where((s) => s.closed == true).map((s) => s.id!);
  int? get firstClosedStatusId => _closedStatusIds.firstOrNull;

  Iterable<int> get _openedStatusIds => statuses.where((s) => s.closed == false).map((s) => s.id!);
  int? get firstOpenedStatusId => _openedStatusIds.firstOrNull;

  ProjectStatus? statusForId(int? id) => statuses.firstWhereOrNull((s) => s.id == id);

  ProjectStatus? get status => statusForId(projectStatusId);

  void setClosed(bool? close) {
    if (close != null) {
      closed = close;
      if (close) {
        // TODO: на бэке нужна эта обработка, чтобы не было косяков из-за неправильно настроенных часов у клиента.
        // TODO: проверить выставление времени на фронте вообще. Не должно быть такого, что время выставляется на фронте
        closedDate = now;
      }
    }
  }
}
