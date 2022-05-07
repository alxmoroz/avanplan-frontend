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

  List<Task> get allTasks => tasks;
  int get tasksCount => allTasks.length;
  int get closedTasksCount => allTasks.where((t) => t.closed).length;
  int get lefTasksCount => tasksCount - closedTasksCount;
  double? get closedRatio => tasksCount > 0 ? closedTasksCount / tasksCount : null;

  double get _factSpeed => closedTasksCount / pastPeriod.inSeconds;
  double get _planSpeed => tasksCount / (plannedPeriod?.inSeconds ?? 1);

  DateTime? get etaDate => _factSpeed > 0 ? DateTime.now().add(Duration(seconds: (lefTasksCount / _factSpeed).round())) : null;
  double? get pace => dueDate != null ? (_factSpeed - _planSpeed) : null;
}
