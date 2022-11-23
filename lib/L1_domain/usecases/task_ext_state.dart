// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:collection/collection.dart';

import '../entities/task.dart';
import 'task_ext_level.dart';

extension TaskStats on Task {
  Duration get lowStartThreshold => const Duration(days: 5);
  static const Duration _overdueThreshold = Duration(days: 1);
  static const Duration _riskThreshold = Duration(days: 1);

  DateTime get _now => DateTime.now();

  void _updateLevels() {
    for (Task t in tasks) {
      t._updateLevels();
    }
    updateLevel();
  }

  void _updateStartDate() {
    for (Task t in tasks) {
      t._updateStartDate();
    }
    startDate ??= _calculateStartDate;
  }

  void _updateSubtasksAndTimings() {
    for (Task t in tasks) {
      t._updateSubtasksAndTimings();
    }
    allTasks = _setAllTasks;
    openedSubtasks = tasks.where((t) => !t.closed);
    closedSubtasks = tasks.where((t) => t.closed);
    leafTasks = allTasks.where((t) => !t.hasSubtasks);
    openedLeafTasks = leafTasks.where((t) => !t.closed);

    isFuture = startDate!.isAfter(_now);

    beforeStartPeriod = startDate!.difference(_now);

    closedDate ??= closed && hasDueDate ? dueDate : null;
    closedPeriod = closedDate != null ? _now.difference(closedDate!) : null;
    final _rawElapsedPeriod = (closedDate ?? _now).difference(startDate!);
    isLowStart = _rawElapsedPeriod < lowStartThreshold;
    elapsedPeriod = isFuture || isLowStart ? null : _rawElapsedPeriod;
    leftPeriod = hasDueDate && !isFuture ? dueDate!.add(_overdueThreshold).difference(_now) : null;
    overduePeriod = hasDueDate ? _now.difference(dueDate!) : null;

    targetVelocity = leftPeriod != null && leftPeriod!.inDays > 0 && !hasOverdue ? openedLeafTasksCount / leftPeriod!.inDays : null;

    final _planPeriod = hasDueDate ? dueDate!.difference(startDate!) : null;
    planVolume = elapsedPeriod != null && _planPeriod != null
        ? min(leafTasksCount.toDouble(), leafTasksCount * elapsedPeriod!.inDays / _planPeriod.inDays)
        : null;
  }

  void _updateVelocity() {
    for (Task t in tasks) {
      t._updateVelocity();
    }
    if (isProject) {
      velocity = _weightedVelocity;
    }
  }

  void _updateRisks() {
    for (Task t in tasks) {
      t._updateRisks();
    }
    etaPeriod = (projectVelocity ?? 0) > 0 && openedLeafTasksCount > 0 ? Duration(days: (openedLeafTasksCount / projectVelocity!).round()) : null;
    etaDate = etaPeriod != null ? _now.add(etaPeriod!) : null;
    riskPeriod = (hasDueDate && hasEtaDate) ? etaDate!.difference(dueDate!) : null;
  }

  void _updateStatedSubtasks() {
    for (Task t in tasks) {
      t._updateStatedSubtasks();
    }
    overdueSubtasks = openedSubtasks.where((t) => t._overallState == TaskState.overdue);
    riskySubtasks = openedSubtasks.where((t) => t._overallState == TaskState.risk);
    okSubtasks = openedSubtasks.where((t) => t._overallState == TaskState.ok);
    etaSubtasks = openedSubtasks.where((t) => t._state == TaskState.eta);
  }

  void _updateState() {
    for (Task t in tasks) {
      t._updateState();
    }
    state = _state;
    subtasksState = _subtasksState;
    overallState = _overallState;
  }

  Task updateRoot() {
    _updateLevels();
    _updateStartDate();
    _updateSubtasksAndTimings();
    _updateVelocity();
    _updateRisks();
    _updateStatedSubtasks();
    _updateState();
    return this;
  }

  Iterable<Task> get _setAllTasks {
    final res = <Task>[];
    for (Task t in tasks) {
      res.addAll(t._setAllTasks);
      res.add(t);
    }
    return res;
  }

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
          start = parent!._calculateStartDate;
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
      start = dueDate!.subtract(_overdueThreshold);
    }
    return start;
  }

  /// скорость проекта
  static const _velocityFrameInDays = 42;
  int? get _elapsedDays => elapsedPeriod?.inDays;
  int? get _closedDays => closedPeriod?.inDays;

  double? get _velocity => _elapsedDays != null ? (closedLeafTasksCount / _elapsedDays!) : null;
  double? get _velocityWeight {
    double? w;
    if (_elapsedDays != null || _closedDays != null) {
      final distance = (_elapsedDays ?? 0) + (_closedDays ?? 0);
      w = distance < _velocityFrameInDays ? (distance / _velocityFrameInDays) : (_velocityFrameInDays / distance);
    }
    return w;
  }

  double? get _weightedVelocity {
    // средняя скорость по проекту без учёта закрытых задач или скоростей целей в пределах окна
    double? v = _velocity;

    // ищем закрытые задачи с датой закрытия в пределах окна
    final referencesTasks = leafTasks.where((t) => t.closed && t.hasClosedDate);
    if (referencesTasks.isNotEmpty && _elapsedDays != null) {
      final closedTasks = referencesTasks.where((t) => t._closedDays! < _velocityFrameInDays).length;
      v = closedTasks / _elapsedDays!;
    } else {
      // если задач с датой закрытия совсем не найдено, то ориентируемся на скорость по целям
      final referencesGoals = tasks.where((t) =>
          !t.isFuture &&
          !t.isBacklog &&
          t._velocity != null &&
          t._velocityWeight != null &&
          (!t.closed || (t.hasClosedDate && t._closedDays! < _velocityFrameInDays)));
      if (referencesGoals.isNotEmpty) {
        final double vSum = referencesGoals.fold(0, (v, t) => v + t._velocity! * t._velocityWeight!);
        final double wSum = referencesGoals.fold(0, (w, t) => w + t._velocityWeight!);
        v = vSum / wSum;
      }
    }

    return v;
  }

  double? get projectVelocity => isWorkspace ? 0 : project!.velocity;

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
    } else if (isLowStart) {
      s = TaskState.lowStart;
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

  int get leafTasksCount => leafTasks.length;
  int get openedLeafTasksCount => openedLeafTasks.length;
  int get closedLeafTasksCount => leafTasksCount - openedLeafTasksCount;

  bool get hasOpenedSubtasks => openedSubtasks.isNotEmpty;
  bool get hasClosedSubtasks => closedSubtasks.isNotEmpty;

  bool get hasSubtasks => tasks.isNotEmpty;
  bool get hasDueDate => dueDate != null;
  bool get hasOverdue => overduePeriod != null && overduePeriod! > _overdueThreshold;
  bool get hasEtaDate => etaDate != null;
  bool get hasClosedDate => closedDate != null;
  bool get hasRisk => riskPeriod != null && riskPeriod! > _riskThreshold;
  bool get isOk => riskPeriod != null && riskPeriod! <= _riskThreshold;
  bool get isAhead => riskPeriod != null && -riskPeriod! > _riskThreshold;
}
