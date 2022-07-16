// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'priority.dart';
import 'status.dart';

enum OverallState { overdue, risk, ok, noInfo }

enum TaskFilter { all, opened, overdue, risky, ok, noDue, closable, inactive }

class Task extends Statusable {
  Task({
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
    this.workspaceId,
    this.status,
    this.priority,
  }) : super(id: id, title: title, closed: closed);

  final String description;
  final DateTime createdOn;
  final DateTime updatedOn;
  final DateTime? dueDate;
  final int? parentId;
  final int? trackerId;
  final Status? status;
  final Priority? priority;
  final int? workspaceId;
  List<Task> tasks;

  Task copy() => Task(
        id: id,
        parentId: parentId,
        createdOn: createdOn,
        updatedOn: updatedOn,
        title: title,
        description: description,
        dueDate: dueDate,
        tasks: tasks,
        closed: closed,
        trackerId: trackerId,
        workspaceId: workspaceId,
      );

  Task copyWithList(List<Task> _list) => Task(
        id: id,
        parentId: parentId,
        createdOn: createdOn,
        updatedOn: updatedOn,
        title: title,
        description: description,
        dueDate: dueDate,
        tasks: _list,
        closed: closed,
        trackerId: trackerId,
        workspaceId: workspaceId,
      );

  bool get isRoot => parentId == null;

  Duration? get plannedPeriod => dueDate?.difference(createdOn);
  Duration get pastPeriod => DateTime.now().difference(createdOn);
  Duration? get overduePeriod => dueDate != null ? DateTime.now().difference(dueDate!) : null;

  Iterable<Task> get allTasks {
    final List<Task> res = [];
    for (Task t in tasks) {
      res.addAll(t.allTasks);
      res.add(t);
    }
    return res;
  }

  Iterable<Task> get leafTasks => allTasks.where((t) => t.allTasks.isEmpty);
  int get leafTasksCount => leafTasks.length;
  int get closedTasksCount => leafTasks.where((t) => t.closed).length;
  int get leftTasksCount => leafTasksCount - closedTasksCount;
  double get doneRatio => leafTasksCount > 0 ? closedTasksCount / leafTasksCount : 0;

  double get _factSpeed => closedTasksCount / pastPeriod.inSeconds;

  DateTime? get etaDate => _factSpeed > 0 && leftTasksCount > 0 ? DateTime.now().add(Duration(seconds: (leftTasksCount / _factSpeed).round())) : null;
  Duration? get etaRiskPeriod => dueDate != null ? etaDate?.difference(dueDate!) : null;

  bool get _hasOverdue => (overduePeriod?.inSeconds ?? 0) > 0;
  bool get _hasRisk => etaDate != null && (etaRiskPeriod?.inSeconds ?? 0) > 0;
  bool get _isOk => etaDate != null && (etaRiskPeriod?.inSeconds ?? 0) <= 0;

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

  // TODO: подумать про перенос сюда выборок по подзадачам (сейчас в контроллере фильтра). Потому что это больше относится к бизнес-логике, а не к интерфейсу
  //  Там есть тудушка про вопрос как определять для корня проекта. Наверное, имеет смысл создать рутовый EW
}
