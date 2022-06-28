// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'task_priority.dart';
import 'task_status.dart';

enum OverallState { overdue, risk, ok, noInfo }

enum EWFilter { all, opened, overdue, risky, ok, noDue, closable, inactive }

class ElementOfWork extends Statusable {
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
  final TaskStatus? status;
  final TaskPriority? priority;
  final int? workspaceId;
  List<ElementOfWork> tasks;

  ElementOfWork copy() => ElementOfWork(
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
      );

  // TODO: возможно, нужно тип задачи вводить просто (как трекер в редмайне)
  bool get isGoal => workspaceId != null;

  Duration? get plannedPeriod => dueDate?.difference(createdOn);
  Duration get pastPeriod => DateTime.now().difference(createdOn);
  Duration? get overduePeriod => dueDate != null ? DateTime.now().difference(dueDate!) : null;

  Iterable<ElementOfWork> get allEW {
    final List<ElementOfWork> res = [];
    for (ElementOfWork ew in tasks) {
      res.addAll(ew.allEW);
      res.add(ew);
    }
    return res;
  }

  Iterable<ElementOfWork> get leafTasks => allEW.where((t) => t.allEW.isEmpty);
  int get tasksCount => leafTasks.length;
  int get closedEWCount => leafTasks.where((t) => t.closed).length;
  int get leftEWCount => tasksCount - closedEWCount;
  double get doneRatio => tasksCount > 0 ? closedEWCount / tasksCount : 0;

  double get _factSpeed => closedEWCount / pastPeriod.inSeconds;

  DateTime? get etaDate => _factSpeed > 0 && leftEWCount > 0 ? DateTime.now().add(Duration(seconds: (leftEWCount / _factSpeed).round())) : null;
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
