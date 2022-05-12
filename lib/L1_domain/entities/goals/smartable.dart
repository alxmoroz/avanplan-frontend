// Copyright (c) 2022. Alexandr Moroz

import '../base_entity.dart';
import 'task.dart';

abstract class Smartable extends Statusable {
  Smartable({
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
  bool get hasOverdue => (overduePeriod?.inSeconds ?? 0) > 0;

  Iterable<Task> get allTasks => tasks;
  Iterable<Task> get leafTasks => allTasks.where((t) => t.allTasks.isEmpty);
  int get tasksCount => leafTasks.length;
  int get closedTasksCount => leafTasks.where((t) => t.closed).length;
  int get lefTasksCount => tasksCount - closedTasksCount;
  double? get closedRatio => tasksCount > 0 && lefTasksCount > 0 ? closedTasksCount / tasksCount : null;

  double get _factSpeed => closedTasksCount / pastPeriod.inSeconds;

  DateTime? get etaDate => _factSpeed > 0 ? DateTime.now().add(Duration(seconds: (lefTasksCount / _factSpeed).round())) : null;
  Duration? get etaRiskPeriod => dueDate != null ? etaDate?.difference(dueDate!) : null;

  bool get hasRisk => etaDate != null && (etaRiskPeriod?.inSeconds ?? 0) > 0;
  bool get ok => etaDate != null && (etaRiskPeriod?.inSeconds ?? 0) <= 0;

  // double get _planSpeed => tasksCount / (plannedPeriod?.inSeconds ?? 1);
  // double? get pace => etaDate != null ? (_factSpeed - _planSpeed) : null;
}
