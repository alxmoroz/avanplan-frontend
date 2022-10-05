// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import '../entities/task.dart';
import 'task_ext_level.dart';

enum TaskState { future, overdue, risk, ok, eta, closable, noDueDate, noSubtasks, noProgress, opened, closed }

extension TaskStats on Task {
  /// непосредственно сама задача
  bool get hasLink => taskSource?.keepConnection == true;

  /// опоздание
  bool get hasDueDate => dueDate != null;
  Duration? get overduePeriod => hasDueDate ? DateTime.now().difference(dueDate!) : null;
  static const Duration _overdueThreshold = Duration(days: 1);
  bool get hasOverdue => overduePeriod != null && overduePeriod! > _overdueThreshold;
  // опоздание по подзадачам
  Duration get maxOverduePeriod => Duration(
        seconds: openedSubtasks.map((t) => t.maxOverduePeriod.inSeconds).fold(
              overduePeriod?.inSeconds ?? 0,
              (s, res) => max(s, res),
            ),
      );
  Iterable<Task> get overdueSubtasks => openedSubtasks.where((t) => t.state == TaskState.overdue);

  /// прогноз
  DateTime get _startDate => createdOn ?? tasks.map((t) => t._startDate).fold(DateTime.now(), (d1, d2) => d1.isAfter(d2) ? d2 : d1);
  Duration get _pastPeriod => DateTime.now().difference(_startDate);
  double get _factSpeed => closedLeafTasksCount / _pastPeriod.inSeconds;
  Duration? get etaPeriod => _factSpeed > 0 && openedLeafTasksCount > 0 ? Duration(seconds: (openedLeafTasksCount / _factSpeed).round()) : null;
  DateTime? get etaDate => etaPeriod != null ? DateTime.now().add(etaPeriod!) : null;
  bool get hasEtaDate => etaDate != null;

  /// риск
  static const Duration _riskThreshold = Duration(days: 1);
  Duration? get riskPeriod => (hasDueDate && hasEtaDate) ? etaDate!.difference(dueDate!) : null;
  bool get hasRisk => riskPeriod != null && riskPeriod! > _riskThreshold;
  // рисковые подзадачи
  Duration get subtasksRiskPeriod => Duration(
        seconds: riskySubtasks.map((t) => t.riskPeriod?.inSeconds ?? t.subtasksRiskPeriod.inSeconds).fold(0, (s, res) => s + res),
      );
  Iterable<Task> get riskySubtasks => tasks.where((t) => t.state == TaskState.risk);

  /// запас, опережение
  Duration? get aheadPeriod => (hasDueDate && hasEtaDate) ? dueDate!.difference(etaDate!) : null;
  bool get isOk => riskPeriod != null && riskPeriod! <= _riskThreshold;
  Duration get totalAheadPeriod => Duration(
        seconds: openedSubtasks.map((t) => max(0, t.totalAheadPeriod.inSeconds)).fold(
              aheadPeriod?.inSeconds ?? 0,
              (s, res) => s + res,
            ),
      );
  bool get isAhead => state == TaskState.ok && totalAheadPeriod >= _riskThreshold;

  /// диаграмма сроков
  Iterable<DateTime> get _sortedDates {
    final dates = [
      if (hasDueDate) dueDate!,
      if (hasEtaDate) etaDate!,
      DateTime.now(),
    ];
    if (dates.length > 1) {
      dates.sort((d1, d2) => d1.compareTo(d2));
    }
    return dates;
  }

  DateTime get _minDate => _sortedDates.first;
  DateTime get _maxDate => _sortedDates.last;
  int get _maxDateSeconds => _maxDate.difference(_minDate).inSeconds;
  double dateRatio(DateTime dt) => _maxDateSeconds > 0 ? (dt.difference(_minDate).inSeconds / _maxDateSeconds) : 1;

  /// подзадачи
  bool get hasSubtasks => tasks.isNotEmpty;
  Iterable<Task> get allTasks {
    final res = <Task>[];
    for (Task t in tasks) {
      res.addAll(t.allTasks);
      res.add(t);
    }
    return res;
  }

  Iterable<Task> get openedSubtasks => tasks.where((t) => !t.closed);
  int get openedSubtasksCount => openedSubtasks.length;
  bool get hasOpenedSubtasks => openedSubtasks.isNotEmpty;

  Iterable<Task> get _closedSubtasks => tasks.where((t) => t.closed);
  bool get hasClosedSubtasks => _closedSubtasks.isNotEmpty;

  Iterable<Task> get _leafTasks => allTasks.where((t) => !t.hasSubtasks);
  int get leafTasksCount => _leafTasks.length;
  Iterable<Task> get _openedLeafTasks => _leafTasks.where((t) => !t.closed);
  int get openedLeafTasksCount => _openedLeafTasks.length;
  int get closedLeafTasksCount => leafTasksCount - openedLeafTasksCount;

  double get doneRatio => (hasDueDate && leafTasksCount > 0) ? closedLeafTasksCount / leafTasksCount : 0;

  /// рекомендации TOI — task of interest
  bool get _isTOI => !closed && (hasSubtasks && (isGoal || (isProject && hasDueDate)));
  Iterable<Task> get _toiTasks => tasks.where((t) => t._isTOI);
  // без срока
  Iterable<Task> get _noDueToi => _toiTasks.where((t) => t.state == TaskState.noDueDate);
  int get noDueToiCount => _noDueToi.length;
  bool get hasNoDueToi => noDueToiCount > 0;
  // без задач
  Iterable<Task> get _emptyToi => _toiTasks.where((t) => t.state == TaskState.noSubtasks);
  int get emptyToiCount => _emptyToi.length;
  bool get hasEmptyToi => emptyToiCount > 0;
  // без прогресса
  int get _closedSubtasksCount => tasks.length - openedSubtasksCount;
  Iterable<Task> get _noProgressToi => _toiTasks.where((t) => t.state == TaskState.noProgress);
  int get noProgressToiCount => _noProgressToi.length;
  bool get hasNoProgressToi => noProgressToiCount > 0;
  // можно закрыть
  bool get isClosable => !closed && hasSubtasks && !hasOpenedSubtasks;
  Iterable<Task> get _closableToi => _toiTasks.where((t) => t.state == TaskState.closable);
  int get closableToiCount => _closableToi.length;
  bool get hasClosableToi => closableToiCount > 0;

  /// подзадачи в порядке
  bool get _hasOkSubtasks => openedSubtasks.isNotEmpty && openedSubtasks.every((t) => t.state == TaskState.ok);

  // TODO(san-smith): я бы подумал, как избавиться от такого вложенного тернарника
  /// интегральный статус
  TaskState get state => closed
      ? TaskState.closed
      : (hasOverdue || (!hasDueDate && overdueSubtasks.isNotEmpty)
          ? TaskState.overdue
          : hasRisk || (!hasDueDate && riskySubtasks.isNotEmpty)
              ? TaskState.risk
              : isOk || ((isWorkspace || isProject) && _hasOkSubtasks)
                  ? TaskState.ok
                  : !hasDueDate && hasEtaDate
                      ? TaskState.eta
                      : isClosable
                          ? TaskState.closable
                          : (!hasDueDate && (!isWorkspace && !isProject && hasSubtasks))
                              ? TaskState.noDueDate
                              : ((isProject || isGoal) && !hasSubtasks)
                                  ? TaskState.noSubtasks
                                  : hasSubtasks && _closedSubtasksCount == 0
                                      ? TaskState.noProgress
                                      : TaskState.opened);
}
