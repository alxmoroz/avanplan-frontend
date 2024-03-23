// Copyright (c) 2023. Alexandr Moroz

import '../entities/task.dart';
import '../utils/dates.dart';
import 'task_source.dart';
import 'task_tree.dart';

extension TaskStatsExtension on Task {
  DateTime get calculatedStartDate => startDate ?? createdOn!;
  Duration? get elapsedPeriod => (closedDate ?? now).difference(calculatedStartDate);

  bool get hasDueDate => dueDate != null;
  bool get hasOverdue => hasDueDate && dueDate!.isBefore(today);
  bool get hasEtaDate => etaDate != null;
  bool get hasClosedDate => closedDate != null;
  bool get hasRisk => state == TaskState.RISK;
  bool get isFuture => state == TaskState.FUTURE_START;
  bool get isOk => state == TaskState.OK;
  bool get isAhead => state == TaskState.AHEAD;

  Duration? get closedPeriod => closedDate != null ? now.difference(closedDate!) : null;
  Duration? get leftPeriod => hasDueDate && !isFuture ? dueDate!.difference(tomorrow) : null;
  Duration? get etaPeriod => etaDate?.difference(now);
  Duration? get riskPeriod => (hasDueDate && hasEtaDate) ? etaDate!.difference(dueDate!) : null;

  num get totalVolume => (openedVolume ?? 0) + (closedVolume ?? 0);

  Duration get beforeStartPeriod => calculatedStartDate.difference(now);

  bool get hasEstimate => openedVolume != null || estimate != null;
  bool get didImported => taskSource != null;
  bool get isImportingProject => isProject && taskSource?.isRunning == true;
  bool get isLinked => didImported && taskSource!.keepConnection;
  bool get isLocal => !isLinked;
  bool get isLinkedProject => isProject && isLinked;

  bool get hasDescription => description.isNotEmpty;
  bool get hasStatus => projectStatusId != null;
  bool get hasAssignee => assigneeId != null;

  bool get hasAuthor => authorId != null;
}
