// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/utils/dates.dart';
import 'task_tree.dart';

TaskState stateFromStr(String strState) => TaskState.values.firstWhereOrNull((s) => s.name == strState) ?? TaskState.NO_INFO;

extension TaskStats on Task {
  DateTime get _now => DateTime.now();

  Duration? get elapsedPeriod => (closedDate ?? _now).difference(calculatedStartDate);

  bool get projectLowStart => project!.state == TaskState.LOW_START;
  double? get projectVelocity => project!.velocity;
  double? get projectRequiredVelocity => project!.requiredVelocity;
  bool get projectHasProgress => project!.progress > 0;

  Duration? get closedPeriod => closedDate != null ? _now.difference(closedDate!) : null;
  Duration? get leftPeriod => hasDueDate && !isFuture ? dueDate!.difference(tomorrow) : null;
  Duration? get etaPeriod => etaDate?.difference(_now);
  Duration? get riskPeriod => (hasDueDate && hasEtaDate) ? etaDate!.difference(dueDate!) : null;

  num get totalVolume => (openedVolume ?? 0) + (closedVolume ?? 0);

  DateTime get calculatedStartDate => startDate ?? createdOn!;
  Duration get beforeStartPeriod => calculatedStartDate.difference(_now);

  bool get hasDueDate => dueDate != null;
  bool get hasOverdue => hasDueDate && dueDate!.isBefore(today);
  bool get hasEtaDate => etaDate != null;
  bool get hasClosedDate => closedDate != null;
  bool get hasRisk => state == TaskState.RISK;
  bool get isFuture => state == TaskState.FUTURE_START;
  bool get isOk => state == TaskState.OK;
  bool get isAhead => state == TaskState.AHEAD;

  bool get hasEstimate => openedVolume != null || estimate != null;
  bool get linked => taskSource?.keepConnection == true;
  bool get wasImported => taskSource?.urlString.isNotEmpty == true;

  bool get hasStatus => statusId != null;
  bool get hasAssignee => assigneeId != null;

  bool get hasDescription => description.isNotEmpty;
  bool get hasAuthor => authorId != null;
}
