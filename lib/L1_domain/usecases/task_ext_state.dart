// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:collection/collection.dart';

import '../entities/task.dart';
import 'task_ext_level.dart';

enum TaskState { overdue, risk, ok, eta, closable, noDueDate, noSubtasks, noProgress, opened, future, backlog, closed }

const _day = Duration(days: 1);

extension TaskStats on Task {
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

  DateTime get _now => DateTime.now();

  /// дата начала
  DateTime get _startDate {
    DateTime? start;
    if (startDate == null) {
      if (parent != null && !parent!.isWorkspace) {
        final siblingsDueDates = parent!.tasks.where((t) => t.hasDueDate).map((t) => t.dueDate!).sorted((d1, d2) => d1.compareTo(d2));
        if (siblingsDueDates.isNotEmpty) {
          if (hasDueDate) {
            start = siblingsDueDates.lastWhereOrNull((d) => dueDate!.isAfter(d));
          } else {
            start = siblingsDueDates.last;
          }
        } else {
          start = parent!._startDate;
        }
      } else if (isWorkspace && hasSubtasks) {
        start = tasks.map((t) => t._startDate).sorted((d1, d2) => d1.compareTo(d2)).first;
      }
    } else {
      start = startDate!;
    }

    start = start ?? createdOn ?? _now;

    // на случай, если выставили срок раньше, чем дату начала, добавляем один день хотя бы
    if (hasDueDate && start.isAfter(dueDate!)) {
      start = dueDate!.subtract(_day);
    }
    return start;
  }

  Duration get startPeriod => _startDate.difference(_now);
  bool get _isFuture => _startDate.isAfter(_now);

  /// опоздание
  bool get hasDueDate => dueDate != null;
  Duration? get overduePeriod => hasDueDate ? _now.difference(dueDate!) : null;
  static const Duration _overdueThreshold = _day;
  bool get hasOverdue => overduePeriod != null && overduePeriod! > _overdueThreshold;
  // максимальное опоздание с учётом подзадач
  Duration get maxOverduePeriod => Duration(
        seconds: openedSubtasks.map((t) => t.maxOverduePeriod.inSeconds).fold(
              overduePeriod?.inSeconds ?? 0,
              (s, res) => max(s, res),
            ),
      );
  Iterable<Task> get overdueSubtasks => openedSubtasks.where((t) => t.state == TaskState.overdue);

  /// фактическая скорость проекта
  Duration? get _pastPeriod => _isFuture ? null : _now.difference(_startDate);
  Task get _projectOrWS => project != null ? project! : this;
  double get projectOrWSSpeed => _projectOrWS._pastPeriod != null ? (_projectOrWS.closedLeafTasksCount / _projectOrWS._pastPeriod!.inSeconds) : 0;

  /// прогноз
  Duration? get etaPeriod =>
      projectOrWSSpeed > 0 && openedLeafTasksCount > 0 ? Duration(seconds: (openedLeafTasksCount / projectOrWSSpeed).round()) : null;
  DateTime? get etaDate => etaPeriod != null ? _now.add(etaPeriod!) : null;
  bool get hasEtaDate => etaDate != null;

  /// целевая скорость
  Duration? get _leftPeriod => hasDueDate && !_isFuture ? dueDate!.add(_overdueThreshold).difference(_now) : null;
  double? get targetSpeed => _leftPeriod != null && !hasOverdue ? openedLeafTasksCount / _leftPeriod!.inSeconds : null;

  /// плановый объем
  Duration? get _planPeriod => hasDueDate ? dueDate!.difference(_startDate) : null;
  double? get planVolume => _pastPeriod != null && _planPeriod != null ? leafTasksCount * _pastPeriod!.inSeconds / _planPeriod!.inSeconds : null;

  /// риск
  static const Duration _riskThreshold = _day;
  Duration? get riskPeriod => (hasDueDate && hasEtaDate) ? etaDate!.difference(dueDate!) : null;
  bool get hasRisk => riskPeriod != null && riskPeriod! > _riskThreshold;
  // рисковые подзадачи
  Duration get subtasksRiskPeriod => Duration(
        seconds: riskySubtasks.map((t) => t.riskPeriod?.inSeconds ?? t.subtasksRiskPeriod.inSeconds).fold(0, (s, res) => s + res),
      );
  Iterable<Task> get riskySubtasks => tasks.where((t) => t.state == TaskState.risk);

  /// запас, опережение
  Duration? get _aheadPeriod => (hasDueDate && hasEtaDate) ? dueDate!.difference(etaDate!) : null;
  bool get isOk => riskPeriod != null && riskPeriod! <= _riskThreshold;
  Duration get totalAheadPeriod => Duration(
        seconds: openedSubtasks.map((t) => max(0, t.totalAheadPeriod.inSeconds)).fold(
              _aheadPeriod?.inSeconds ?? 0,
              (s, res) => s + res,
            ),
      );
  bool get isAhead => state == TaskState.ok && totalAheadPeriod >= _riskThreshold;

  /// диаграмма сроков
  Iterable<DateTime> get _sortedDates {
    final dates = [
      if (hasDueDate) dueDate!,
      if (hasEtaDate) etaDate!,
      _now,
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

  // double get doneRatio => (hasDueDate && leafTasksCount > 0) ? closedLeafTasksCount / leafTasksCount : 0;

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
  Iterable<Task> get _noProgressToi => _toiTasks.where((t) => t.state == TaskState.noProgress);
  int get noProgressToiCount => _noProgressToi.length;
  bool get hasNoProgressToi => noProgressToiCount > 0;
  // можно закрыть
  Iterable<Task> get _closableToi => _toiTasks.where((t) => t.state == TaskState.closable);
  int get closableToiCount => _closableToi.length;
  bool get hasClosableToi => closableToiCount > 0;

  /// подзадачи в порядке
  bool get _hasOkSubtasks => openedSubtasks.isNotEmpty && openedSubtasks.every((t) => t.state == TaskState.ok);
  bool get _allSubtasksAreClosable => openedSubtasks.isNotEmpty && openedSubtasks.every((t) => t.state == TaskState.closable);

  // TODO(san-smith): я бы подумал, как избавиться от такого вложенного тернарника
  /// интегральный статус
  TaskState get state => closed
      ? TaskState.closed
      : isBacklog
          ? TaskState.backlog
          : ((isProject || isGoal) && !hasSubtasks)
              ? TaskState.noSubtasks
              : _isFuture && hasOpenedSubtasks
                  ? TaskState.future
                  : !isWorkspace && hasOpenedSubtasks && !hasEtaDate
                      ? TaskState.noProgress
                      : !isWorkspace && hasSubtasks && (!hasOpenedSubtasks || _allSubtasksAreClosable)
                          ? TaskState.closable
                          : !hasDueDate && hasEtaDate
                              ? TaskState.eta
                              : (hasOverdue || (!hasDueDate && overdueSubtasks.isNotEmpty)
                                  ? TaskState.overdue
                                  : hasRisk || (!hasDueDate && riskySubtasks.isNotEmpty)
                                      ? TaskState.risk
                                      : isOk || ((isWorkspace || isProject) && _hasOkSubtasks)
                                          ? TaskState.ok
                                          : (!hasDueDate && (!isWorkspace && !isProject && hasSubtasks))
                                              ? TaskState.noDueDate
                                              : TaskState.opened);
}
