// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/workspace.dart';
import 'member.dart';
import 'note.dart';
import 'project_status.dart';
import 'task_source.dart';

extension TaskMapper on api.TaskGet {
  Task task({required Workspace ws, Task? parent}) {
    final ts = taskSource?.taskSource;
    String _title = title?.trim() ?? '';
    if (type != null && type?.toLowerCase() == 'backlog') {
      _title = Intl.message(_title);
    }

    final _t = Task(
      id: id,
      createdOn: createdOn.toLocal(),
      updatedOn: updatedOn.toLocal(),
      title: _title,
      type: type,
      description: description?.trim() ?? '',
      startDate: startDate?.toLocal(),
      closedDate: closedDate?.toLocal(),
      dueDate: dueDate?.toLocal(),
      closed: closed ?? false,
      statusId: statusId,
      estimate: estimate,
      tasks: [],
      notes: notes?.map((n) => n.note).toList() ?? [],
      authorId: authorId,
      assigneeId: assigneeId,
      members: members?.map((m) => m.member(id)).toList() ?? [],
      projectStatuses: projectStatuses?.map((ps) => ps.projectStatus).toList() ?? [],
      taskSource: ts,
      parent: parent,
      ws: ws,
      state: state ?? '',
      elapsedPeriod: Duration(seconds: elapsedPeriod?.toInt() ?? 0),
      etaPeriod: Duration(seconds: etaPeriod?.toInt() ?? 0),
      riskPeriod: Duration(seconds: riskPeriod?.toInt() ?? 0),
      isFuture: isFuture ?? false,
      etaDate: etaDate?.toLocal(),
      showSP: showSp ?? false,
      targetVelocity: targetVelocity?.toDouble(),
    );
    _t.tasks = tasks?.map((t) => t.task(ws: ws, parent: _t)).toList() ?? [];
    return _t;
  }
}

extension TaskImportMapper on api.TaskRemote {
  TaskRemote get taskImport => TaskRemote(
        title: title ?? '??',
        description: description ?? '',
        taskSource: taskSource?.taskSourceImport,
      );
}
