// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../utils/dates.dart';
import 'task_state.dart';

extension TaskDatesExt on Task {
  bool get hasRepeat => (repeatsCount ?? 0) > 0 || repeat != null;
  bool get hasDueDate => dueDate != null;
  bool get hasEtaDate => etaDate != null;
  bool get hasClosedDate => closedDate != null;

  DateTime get calculatedStartDate => startDate ?? createdOn!;
  Duration? get elapsedPeriod => (closedDate ?? now).difference(calculatedStartDate);
  Duration? get closedPeriod => closedDate != null ? now.difference(closedDate!) : null;
  Duration? get leftPeriod => hasDueDate && !isFuture ? dueDate!.difference(tomorrow) : null;
  Duration? get etaPeriod => etaDate?.difference(now);
  Duration? get riskPeriod => (hasDueDate && hasEtaDate) ? etaDate!.difference(dueDate!) : null;
  Duration get beforeStartPeriod => calculatedStartDate.difference(now);
}
