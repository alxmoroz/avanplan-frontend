// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/task.dart';
import 'member.dart';
import 'task_source.dart';

extension TaskMapper on api.TaskGet {
  Task task({required int wsId, Task? parent}) {
    final ts = taskSource?.taskSource(wsId);
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
      authorId: authorId,
      assigneeId: assigneeId,
      members: members?.map((m) => m.member(id)).toList() ?? [],
      taskSource: ts,
      parent: parent,
      wsId: wsId,
    );
    _t.tasks = tasks?.map((t) => t.task(wsId: wsId, parent: _t)).toList() ?? [];
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
