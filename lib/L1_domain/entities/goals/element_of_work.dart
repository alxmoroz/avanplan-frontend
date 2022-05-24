// Copyright (c) 2022. Alexandr Moroz

import '../base_entity.dart';
import 'task.dart';

enum OverallState { overdue, risk, ok, noInfo }

abstract class ElementOfWork extends Statusable {
  ElementOfWork({
    required int id,
    required String title,
    required bool closed,
    required this.tasks,
    required this.description,
    required this.createdOn,
    required this.updatedOn,
    required this.dueDate,
    required this.parentId,
    required this.trackerId,
  }) : super(id: id, title: title, closed: closed);

  final String description;
  final DateTime createdOn;
  final DateTime updatedOn;
  final DateTime? dueDate;
  final int? parentId;
  final int? trackerId;
  List<Task> tasks;

  Duration? get plannedPeriod => dueDate?.difference(createdOn);
  Duration get pastPeriod => DateTime.now().difference(createdOn);
  Duration? get overduePeriod => dueDate != null ? DateTime.now().difference(dueDate!) : null;

  Iterable<Task> get allTasks => tasks;
  Iterable<Task> get leafTasks => allTasks.where((t) => t.allTasks.isEmpty);
  int get tasksCount => leafTasks.length;
  int get closedTasksCount => leafTasks.where((t) => t.closed).length;
  int get lefTasksCount => tasksCount - closedTasksCount;
  double get doneRatio => tasksCount > 0 ? closedTasksCount / tasksCount : 0;

  double get _factSpeed => closedTasksCount / pastPeriod.inSeconds;

  DateTime? get etaDate => _factSpeed > 0 && lefTasksCount > 0 ? DateTime.now().add(Duration(seconds: (lefTasksCount / _factSpeed).round())) : null;
  Duration? get etaRiskPeriod => dueDate != null ? etaDate?.difference(dueDate!) : null;

  bool get _hasOverdue => (overduePeriod?.inSeconds ?? 0) > 0;
  bool get _hasRisk => etaDate != null && (etaRiskPeriod?.inSeconds ?? 0) > 0;
  bool get _isOk => etaDate != null && (etaRiskPeriod?.inSeconds ?? 0) <= 0;

  //TODO: оставить только этот статус. Остальные выше сделать приватными
  OverallState get overallState => dueDate != null && !closed
      ? (_hasOverdue
          ? OverallState.overdue
          : _hasRisk
              ? OverallState.risk
              : _isOk
                  ? OverallState.ok
                  : OverallState.noInfo)
      : OverallState.noInfo;
  // double get _planSpeed => tasksCount / (plannedPeriod?.inSeconds ?? 1);
  // double? get pace => etaDate != null ? (_factSpeed - _planSpeed) : null;
}
