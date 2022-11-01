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
  Iterable<Task> get overdueSubtasks => openedSubtasks.where((t) => [TaskState.overdue, TaskState.overdueSubtasks].contains(t.state));

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
  double? get planVolume => _pastPeriod != null && _planPeriod != null
      ? min(leafTasksCount.toDouble(), leafTasksCount * _pastPeriod!.inSeconds / _planPeriod!.inSeconds)
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
      if (_isFuture) {
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
