// Copyright (c) 2023. Alexandr Moroz

import 'dart:math';

import 'package:collection/collection.dart';

import '../entities/task.dart';
import '../entities_extensions/task_level.dart';

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
    leafTasks = allTasks.where((t) => t.isLeaf);
    openedLeafTasks = leafTasks.where((t) => !t.closed);
    closedLeafTasks = leafTasks.where((t) => t.closed);

    // суммарная оценка в приоритете над локальной
    estimate = _sumEstimate(openedLeafTasks) ?? estimate;

    isFuture = startDate!.isAfter(_now);
    beforeStartPeriod = startDate!.difference(_now);

    closedDate ??= closed && hasDueDate ? dueDate : null;
    closedPeriod = closedDate != null ? _now.difference(closedDate!) : null;
    elapsedPeriod = (closedDate ?? _now).difference(startDate!);
    leftPeriod = hasDueDate && !isFuture ? dueDate!.add(_overdueThreshold).difference(_now) : null;
    overduePeriod = hasDueDate ? _now.difference(dueDate!) : null;

    final _planPeriod = hasDueDate ? dueDate!.difference(startDate!) : null;
    planVolume = !isFuture && _planPeriod != null ? min(leafTasksCount.toDouble(), leafTasksCount * elapsedPeriod.inDays / _planPeriod.inDays) : null;
  }

  static int? _sumEstimate(Iterable<Task> tasks) {
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
        velocityTasks = closedLeafTasksCount / elapsedDays;
        final closedEstimate = _sumEstimate(closedLeafTasks);
        velocitySP = closedEstimate != null ? closedEstimate / elapsedDays : null;

        // ищем закрытые задачи с датой закрытия в пределах окна
        final closedTasks = leafTasks.where((t) => t.closed && t.hasClosedDate && t._closedDays! < velocityFrameInDays);
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
    showSP = estimate != null && pVelocitySP != null;
    final leftCapacity = showSP ? estimate! : openedLeafTasksCount;
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
    final t = Task(
      id: id,
      description: description,
      title: title,
      closed: closed,
      parent: parent,
      tasks: tasks,
      wsId: wsId,
      members: members,
      createdOn: createdOn,
      updatedOn: updatedOn,
      dueDate: dueDate,
      startDate: startDate,
      closedDate: closedDate,
      status: status,
      priority: priority,
      authorId: authorId,
      assigneeId: assigneeId,
      taskSource: taskSource,
      type: type,
      estimate: estimate,
    );

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
      start = dueDate!.subtract(_overdueThreshold);
    }
    return start;
  }

  double? get projectVelocity => isRoot ? 0 : (showSP ? project!.velocitySP : project!.velocityTasks);

  bool get projectLowStart => isRoot ? false : project!.isLowStart == true;
  Duration? get projectStartEtaCalcPeriod => isRoot ? null : project!.startDate!.add(lowStartThreshold).difference(_now);
  bool get projectHasProgress => isRoot ? true : project!.closedLeafTasksCount > 0;

  bool _allOpenedSubtasksAre(TaskState state) => openedSubtasks.isNotEmpty && !openedSubtasks.any((t) => t._state != state);

  /// интегральный статус
  TaskState get _state {
    TaskState s = TaskState.opened;

    if (closed) {
      s = TaskState.closed;
    } else if (isLeaf) {
      if (!(isTask || isSubtask)) {
        s = TaskState.noSubtasks;
      }
    }
    // есть подзадачи
    else {
      if (!hasOpenedSubtasks || _allOpenedSubtasksAre(TaskState.closable)) {
        s = TaskState.closable;
      } else if (isFuture) {
        s = TaskState.future;
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
      } else if ((isProject || isGoal) && projectLowStart) {
        s = TaskState.noInfo;
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

  // bool get isBacklog => type?.title == 'backlog';

  int get leafTasksCount => leafTasks.length;
  int get openedLeafTasksCount => openedLeafTasks.length;
  int get closedLeafTasksCount => closedLeafTasks.length;

  bool get hasOpenedSubtasks => openedSubtasks.isNotEmpty;
  bool get hasClosedSubtasks => closedSubtasks.isNotEmpty;

  bool get hasSubtasks => tasks.isNotEmpty;
  bool get isLeaf => !hasSubtasks;
  bool get hasDueDate => dueDate != null;
  bool get hasOverdue => overduePeriod != null && overduePeriod! > _overdueThreshold;
  bool get hasEtaDate => etaDate != null;
  bool get hasClosedDate => closedDate != null;
  bool get hasRisk => riskPeriod != null && riskPeriod! > _riskThreshold;
  bool get isOk => riskPeriod != null && riskPeriod! <= _riskThreshold;
  bool get isAhead => riskPeriod != null && -riskPeriod! > _riskThreshold;

  bool get hasEstimate => estimate != null;
  bool get hasLink => taskSource?.keepConnection == true;
}
