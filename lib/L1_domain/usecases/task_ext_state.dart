// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:collection/collection.dart';

import '../entities/task.dart';
import 'task_ext_level.dart';

extension TaskStats on Task {
  static const _day = Duration(days: 1);
  static const _week = Duration(days: 7);

  static const Duration _startThreshold = _week;
  static const Duration _overdueThreshold = _day;
  static const Duration _riskThreshold = _day;

  DateTime get _now => DateTime.now();

  Task update() {
    // TODO: костыли из-за необходимости знать инфу о родителе и братьях
    updateLevel();
    calculatedStartDate = _calculateStartDate;

    for (Task t in tasks) {
      t.update();
    }

    allTasks = _setAllTasks;
    openedSubtasks = tasks.where((t) => !t.closed);
    closedSubtasks = tasks.where((t) => t.closed);
    leafTasks = allTasks.where((t) => !t.hasSubtasks);
    openedLeafTasks = leafTasks.where((t) => !t.closed);

    isFuture = calculatedStartDate.isAfter(_now);

    startPeriod = calculatedStartDate.difference(_now);
    final _rawElapsedPeriod = _now.difference(calculatedStartDate);
    elapsedPeriod = isFuture || _rawElapsedPeriod < _startThreshold ? null : _rawElapsedPeriod;
    leftPeriod = hasDueDate && !isFuture ? dueDate!.add(_overdueThreshold).difference(_now) : null;
    overduePeriod = hasDueDate ? _now.difference(dueDate!) : null;

    weightedVelocity = _weightedVelocity;
    targetVelocity = leftPeriod != null && leftPeriod!.inDays > 0 && !hasOverdue ? openedLeafTasksCount / leftPeriod!.inDays : null;

    etaPeriod = weightedVelocity > 0 && openedLeafTasksCount > 0 ? Duration(days: (openedLeafTasksCount / weightedVelocity).round()) : null;
    etaDate = etaPeriod != null ? _now.add(etaPeriod!) : null;

    riskPeriod = (hasDueDate && hasEtaDate) ? etaDate!.difference(dueDate!) : null;

    /// плановый объем
    final _planPeriod = hasDueDate ? dueDate!.difference(calculatedStartDate) : null;
    planVolume = elapsedPeriod != null && _planPeriod != null
        ? min(leafTasksCount.toDouble(), leafTasksCount * elapsedPeriod!.inDays / _planPeriod.inDays)
        : null;

    _updateState();
    return this;
  }

  void _updateState() {
    for (Task t in tasks) {
      t._updateState();
    }
    state = _state;
    subtasksState = _subtasksState;
    overallState = _overallState;

    overdueSubtasks = openedSubtasks.where((t) => t.overallState == TaskState.overdue);
    riskySubtasks = openedSubtasks.where((t) => t.overallState == TaskState.risk);
    okSubtasks = openedSubtasks.where((t) => t.overallState == TaskState.ok);
    etaSubtasks = openedSubtasks.where((t) => t.state == TaskState.eta);
  }

  Iterable<Task> get _setAllTasks {
    final res = <Task>[];
    for (Task t in tasks) {
      res.addAll(t._setAllTasks);
      res.add(t);
    }
    return res;
  }

  bool get hasOpenedSubtasks => openedSubtasks.isNotEmpty;
  bool get hasClosedSubtasks => closedSubtasks.isNotEmpty;
  int get leafTasksCount => leafTasks.length;
  int get openedLeafTasksCount => openedLeafTasks.length;
  int get closedLeafTasksCount => leafTasksCount - openedLeafTasksCount;

  /// дата начала
  DateTime get _calculateStartDate {
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
        start = tasks.map((t) => t._calculateStartDate).sorted((d1, d2) => d1.compareTo(d2)).first;
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

  /// скорость (проекта, цели, средневзвешенная)
  double get _weightedVelocity {
    final _projectOrWS = project != null ? project! : this;
    final _projectElapsedPeriod = _projectOrWS.elapsedPeriod;
    final double _projectVelocity = _projectElapsedPeriod != null ? (_projectOrWS.closedLeafTasksCount / _projectElapsedPeriod.inDays) : 0;
    final _velocity = elapsedPeriod != null ? (closedLeafTasksCount / elapsedPeriod!.inDays) : 0;
    const _baseVelocityDays = 42;
    final _elapsedDays = elapsedPeriod?.inDays ?? 0;
    final _weightPeriod = max(_elapsedDays, _baseVelocityDays);
    return isProject ? _projectVelocity : (_projectVelocity * (_weightPeriod - _elapsedDays) + _velocity * _elapsedDays) / _weightPeriod;
  }

  bool _allOpenedSubtasksAre(TaskState state) => openedSubtasks.isNotEmpty && !openedSubtasks.any((t) => t._state != state);

  /// интегральный статус
  TaskState get _state {
    TaskState s = TaskState.noInfo;

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
      } else if (isOk) {
        s = TaskState.ok;
      }
    } else if (hasEtaDate) {
      s = TaskState.eta;
    }
    return s;
  }

  TaskState get _subtasksState {
    TaskState s = TaskState.noInfo;

    if (overdueSubtasks.isNotEmpty) {
      s = TaskState.overdue;
    } else if (riskySubtasks.isNotEmpty) {
      s = TaskState.risk;
    } else if (okSubtasks.isNotEmpty) {
      s = TaskState.ok;
    } else if (etaSubtasks.isNotEmpty) {
      s = TaskState.eta;
    }

    return s;
  }

  TaskState get _overallState {
    final st = _state;
    final subSt = _subtasksState;

    return ![TaskState.noInfo, TaskState.eta].contains(st)
        ? st
        : subSt != TaskState.noInfo
            ? subSt
            : st;
  }

  bool get isBacklog => type?.title == 'backlog';

  bool get hasSubtasks => tasks.isNotEmpty;
  bool get hasDueDate => dueDate != null;
  bool get hasOverdue => overduePeriod != null && overduePeriod! > _overdueThreshold;
  bool get hasEtaDate => etaDate != null;
  bool get hasRisk => riskPeriod != null && riskPeriod! > _riskThreshold;
  bool get isOk => riskPeriod != null && riskPeriod! <= _riskThreshold;
  bool get isAhead => riskPeriod != null && -riskPeriod! > _riskThreshold;
}
