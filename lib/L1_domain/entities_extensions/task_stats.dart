// Copyright (c) 2023. Alexandr Moroz

import 'dart:math';

import 'package:collection/collection.dart';

import '../../L3_app/presenters/date_presenter.dart';
import '../entities/task.dart';
import '../entities_extensions/task_level.dart';

extension TaskStats on Task {
  Duration get lowStartThreshold => const Duration(days: 5);
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
    leaves = allTasks.where((t) => t.isLeaf);
    openedLeaves = leaves.where((t) => !t.closed);
    openedAssignedLeaves = openedLeaves.where((t) => t.assigneeId != null);
    closedLeaves = leaves.where((t) => t.closed);

    isFuture = startDate!.isAfter(tomorrow);
    beforeStartPeriod = startDate!.difference(_now);

    closedDate ??= closed && hasDueDate ? dueDate : null;
    closedPeriod = closedDate != null ? _now.difference(closedDate!) : null;
    elapsedPeriod = (closedDate ?? _now).difference(startDate!);
    leftPeriod = hasDueDate && !isFuture ? dueDate!.difference(tomorrow) : null;

    final _planPeriod = hasDueDate ? dueDate!.difference(startDate!) : null;
    planVolume = !isFuture && _planPeriod != null ? min(leavesCount.toDouble(), leavesCount * elapsedPeriod.inDays / _planPeriod.inDays) : null;
  }

  // суммарная оценка в приоритете над локальной

  int? _sumEstimate(Iterable<Task> tasks) {
    int? res;
    final count = tasks.length;
    if (count > 0) {
      final noEstimateTasks = tasks.where((t) => t.estimate == null);
      final hasEstimate = noEstimateTasks.length / count < 0.75;
      if (hasEstimate) {
        res = tasks.fold<int>(0, (est, t) => (t.estimate ?? 0) + est);
        final avg = res / count;
        res += (avg * noEstimateTasks.length).round();
      }
    }
    return res;
  }

  int? get sumEstimate => _sumEstimate(openedLeaves) ?? estimate;

  /// скорость проекта
  int? get _closedDays => closedPeriod?.inDays;
  void _updateVelocity() {
    for (Task t in tasks) {
      t._updateVelocity();
    }

    if (isProject) {
      isLowStart = elapsedPeriod < lowStartThreshold;
      if (isLowStart == false) {
        const velocityFrameInDays = 42;
        final elapsedDays = elapsedPeriod.inDays;
        // средняя скорость по проекту без учёта закрытых задач или скоростей целей в пределах окна
        velocityTasks = closedLeavesCount / elapsedDays;
        final closedEstimate = _sumEstimate(closedLeaves);
        velocitySP = closedEstimate != null ? closedEstimate / elapsedDays : null;

        // ищем закрытые задачи с датой закрытия в пределах окна
        final closedTasks = leaves.where((t) => t.closed && t.hasClosedDate && t._closedDays! < velocityFrameInDays);
        if (closedTasks.isNotEmpty) {
          final closedEstimate = _sumEstimate(closedTasks);
          velocityTasks = closedTasks.length / min(elapsedDays, velocityFrameInDays);
          velocitySP = closedEstimate != null ? (closedEstimate / min(elapsedDays, velocityFrameInDays)) : null;
        }
      }
    }
  }

  void _updateRisks() {
    for (Task t in tasks) {
      t._updateRisks();
    }

    final pVelocitySP = isRoot ? null : project!.velocitySP;
    showSP = sumEstimate != null && pVelocitySP != null;
    final leftCapacity = showSP ? sumEstimate! : openedLeavesCount;
    if (leftPeriod != null && leftPeriod!.inDays > 0 && !hasOverdue) {
      targetVelocity = leftCapacity / leftPeriod!.inDays;
    }

    etaPeriod = (projectVelocity ?? 0) > 0 && leftCapacity > 0 ? Duration(days: (leftCapacity / projectVelocity!).ceil()) : null;
    etaDate = etaPeriod != null ? (isFuture ? startDate! : _now).add(etaPeriod!) : null;
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
    openedFilledSiblings = parent != null ? parent!.openedSubtasks.where((t) => t.id != id && t.hasOpenedSubtasks) : [];
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
    final t = Task.dummy;
    t.tasks = tasks;

    t._updateLevels();
    t._updateStartDate();
    t._updateSubtasksAndTimings();
    t._updateVelocity();
    t._updateRisks();
    t._updateStatedSubtasks();
    t._updateState();
    return t;
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
    if (parent != null && !parent!.isRoot) {
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
    }

    start = start ?? createdOn ?? _now;

    // на случай, если выставили срок раньше, чем дату начала, добавляем один день хотя бы
    if (hasDueDate && start.isAfter(dueDate!)) {
      start = dueDate!.subtract(const Duration(days: 1));
    }
    return start;
  }

  double? get projectVelocity => isRoot ? 0 : (showSP ? project!.velocitySP : project!.velocityTasks);

  bool get projectLowStart => isRoot ? false : project!.isLowStart == true;
  Duration? get projectStartEtaCalcPeriod => isRoot ? null : project!.startDate!.add(lowStartThreshold).difference(_now);
  bool get projectHasProgress => isRoot ? true : project!.closedLeavesCount > 0;

  bool _allOpenedSubtasksAre(TaskState state) => openedSubtasks.isNotEmpty && !openedSubtasks.any((t) => t._state != state);

  /// интегральный статус
  TaskState get _state {
    TaskState s = TaskState.noInfo;

    if (closed) {
      s = TaskState.closed;
    } else if (!hasSubtasks) {
      if (!(isTask || isSubtask)) {
        s = TaskState.noSubtasks;
      } else if (hasDueDate) {
        if (hasOverdue) {
          s = TaskState.overdue;
        } else if (dueDate!.isAfter(yesterday) && dueDate!.isBefore(tomorrow)) {
          s = TaskState.today;
        } else if (dueDate!.isAfter(today) && dueDate!.isBefore(nextWeek)) {
          s = TaskState.thisWeek;
        } else if (dueDate!.isAfter(nextWeek)) {
          s = TaskState.futureDue;
        } else {
          s = TaskState.opened;
        }
      } else {
        s = TaskState.noDue;
      }
    }
    // есть подзадачи
    else {
      if (!hasOpenedSubtasks || _allOpenedSubtasksAre(TaskState.closable)) {
        s = TaskState.closable;
      } else if (isFuture) {
        s = TaskState.futureStart;
      } else if (!projectHasProgress) {
        s = TaskState.noProgress;
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

    return ![TaskState.opened, TaskState.eta, TaskState.noInfo].contains(st)
        ? st
        : subSt != TaskState.noInfo
            ? subSt
            : st;
  }

  int get leavesCount => leaves.length;
  int get openedLeavesCount => openedLeaves.length;
  int get closedLeavesCount => closedLeaves.length;

  bool get hasOpenedSubtasks => openedSubtasks.isNotEmpty;
  bool get hasOpenedFilledSiblings => openedFilledSiblings.isNotEmpty;
  bool get hasClosedSubtasks => closedSubtasks.isNotEmpty;

  bool get hasDueDate => dueDate != null;
  bool get hasOverdue => hasDueDate && dueDate!.isBefore(today);
  bool get hasEtaDate => etaDate != null;
  bool get hasClosedDate => closedDate != null;
  bool get hasRisk => riskPeriod != null && riskPeriod! > _riskThreshold;
  bool get isOk => riskPeriod != null && riskPeriod! <= _riskThreshold;
  bool get isAhead => riskPeriod != null && -riskPeriod! > _riskThreshold;

  bool get hasEstimate => sumEstimate != null;
  bool get linked => taskSource?.keepConnection == true;
  bool get wasImported => taskSource?.urlString.isNotEmpty == true;

  bool get hasStatus => statusId != null;
  bool get hasAssignee => assigneeId != null;

  bool get hasDescription => description.isNotEmpty;
  bool get hasAuthor => authorId != null;
}
