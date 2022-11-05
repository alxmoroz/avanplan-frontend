// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:collection/collection.dart';

import '../entities/task.dart';
import 'task_ext_level.dart';

enum TaskState {
  overdue,
  overdueSubtasks,
  risk,
  riskSubtasks,
  ok,
  okSubtasks,
  ahead,
  aheadSubtasks,
  eta,
  closable,
  noSubtasks,
  noProgress,
  opened,
  future,
  noInfo,
  backlog,
  closed,
}

const _day = Duration(days: 1);
const _week = Duration(days: 7);

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
  DateTime get calculatedStartDate {
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
          start = parent!.calculatedStartDate;
        }
      } else if (isWorkspace && hasSubtasks) {
        start = tasks.map((t) => t.calculatedStartDate).sorted((d1, d2) => d1.compareTo(d2)).first;
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

  Duration get startPeriod => calculatedStartDate.difference(_now);
  bool get isFuture => calculatedStartDate.isAfter(_now);

  /// опоздание
  bool get hasDueDate => dueDate != null;
  Duration? get overduePeriod => hasDueDate ? _now.difference(dueDate!) : null;
  static const Duration _overdueThreshold = _day;
  bool get hasOverdue => overduePeriod != null && overduePeriod! > _overdueThreshold;
  Iterable<Task> get overdueSubtasks => openedSubtasks.where((t) => [TaskState.overdue, TaskState.overdueSubtasks].contains(t.state));

  /// скорость (проекта, цели, средневзвешенная)
  static const Duration _startThreshold = _week;
  Duration get _rawElapsedPeriod => _now.difference(calculatedStartDate);
  Duration? get elapsedPeriod => isFuture || _rawElapsedPeriod < _startThreshold ? null : _rawElapsedPeriod;

  Duration? get _projectElapsedPeriod => _projectOrWS.elapsedPeriod;
  Task get _projectOrWS => project != null ? project! : this;
  double get _projectVelocity => _projectElapsedPeriod != null ? (_projectOrWS.closedLeafTasksCount / _projectElapsedPeriod!.inDays) : 0;
  double get _velocity => elapsedPeriod != null ? (closedLeafTasksCount / elapsedPeriod!.inDays) : 0;

  static const int _baseVelocityDays = 42;
  int get _elapsedDays => elapsedPeriod?.inDays ?? 0;
  int get _weightPeriod => max(_elapsedDays, _baseVelocityDays);
  double get weightedVelocity =>
      isProject ? _projectVelocity : (_projectVelocity * (_weightPeriod - _elapsedDays) + _velocity * _elapsedDays) / _weightPeriod;

  /// прогноз
  Duration? get etaPeriod =>
      weightedVelocity > 0 && openedLeafTasksCount > 0 ? Duration(days: (openedLeafTasksCount / weightedVelocity).round()) : null;
  DateTime? get etaDate => etaPeriod != null ? _now.add(etaPeriod!) : null;
  bool get hasEtaDate => etaDate != null;

  /// целевая скорость
  Duration? get leftPeriod => hasDueDate && !isFuture ? dueDate!.add(_overdueThreshold).difference(_now) : null;
  double? get targetVelocity => leftPeriod != null && !hasOverdue ? openedLeafTasksCount / leftPeriod!.inDays : null;

  /// плановый объем
  Duration? get _planPeriod => hasDueDate ? dueDate!.difference(calculatedStartDate) : null;
  double? get planVolume => elapsedPeriod != null && _planPeriod != null
      ? min(leafTasksCount.toDouble(), leafTasksCount * elapsedPeriod!.inDays / _planPeriod!.inDays)
      : null;

  /// риск
  static const Duration _riskThreshold = _day;
  Duration? get riskPeriod => (hasDueDate && hasEtaDate) ? etaDate!.difference(dueDate!) : null;
  bool get hasRisk => riskPeriod != null && riskPeriod! > _riskThreshold;
  Iterable<Task> get riskySubtasks => openedSubtasks.where((t) => [TaskState.risk, TaskState.riskSubtasks].contains(t.state));

  /// ok
  bool get isOk => riskPeriod != null && riskPeriod! <= _riskThreshold;
  Iterable<Task> get okSubtasks => openedSubtasks.where((t) => [TaskState.ok, TaskState.okSubtasks].contains(t.state));

  /// опережение
  bool get isAhead => riskPeriod != null && -riskPeriod! > _riskThreshold;
  Iterable<Task> get aheadSubtasks => openedSubtasks.where((t) => [TaskState.ahead, TaskState.aheadSubtasks].contains(t.state));

  /// только прогноз
  Iterable<Task> get etaSubtasks => openedSubtasks.where((t) => t.state == TaskState.eta);

  // double get doneRatio => (hasDueDate && leafTasksCount > 0) ? closedLeafTasksCount / leafTasksCount : 0;

  bool _allOpenedSubtasksAre(TaskState state) => openedSubtasks.isNotEmpty && !openedSubtasks.any((t) => t.state != state);

  /// интегральный статус
  TaskState get state {
    TaskState s = TaskState.opened;

    if (closed) {
      s = TaskState.closed;
    } else if (isBacklog) {
      s = TaskState.backlog;
    } else if (!(isTask || isSubtask) && !hasSubtasks || _allOpenedSubtasksAre(TaskState.backlog)) {
      s = TaskState.noSubtasks;
    } else if (hasSubtasks && !hasOpenedSubtasks || _allOpenedSubtasksAre(TaskState.closable)) {
      s = TaskState.closable;
    } else if (!isWorkspace && hasSubtasks && closedLeafTasksCount == 0) {
      if (isFuture) {
        s = TaskState.future;
      } else {
        s = TaskState.noProgress;
      }
    } else if (hasDueDate) {
      if (hasOverdue) {
        s = TaskState.overdue;
      } else if (hasRisk) {
        s = TaskState.risk;
      } else if (isAhead) {
        s = TaskState.ahead;
      } else if (isOk) {
        s = TaskState.ok;
      } else {
        s = TaskState.noInfo;
      }
    } else if (hasSubtasks) {
      if (overdueSubtasks.isNotEmpty) {
        s = TaskState.overdueSubtasks;
      } else if (riskySubtasks.isNotEmpty) {
        s = TaskState.riskSubtasks;
      } else if (okSubtasks.isNotEmpty) {
        s = TaskState.okSubtasks;
      } else if (aheadSubtasks.isNotEmpty) {
        s = TaskState.aheadSubtasks;
      } else if (etaSubtasks.isNotEmpty) {
        s = TaskState.eta;
      } else {
        s = TaskState.noInfo;
      }
    }

    return s;
  }
}
