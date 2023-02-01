// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/task.dart';
import 'member.dart';
import 'priority.dart';
import 'status.dart';
import 'task_source.dart';

extension TaskMapper on api.TaskGet {
  Task task({required int wsId, Task? parent}) {
    final ts = taskSource?.taskSource;
    String _title = title?.trim() ?? '';
    if (type != null && type?.toLowerCase() == 'backlog') {
      _title = Intl.message(_title);
    }

    // TODO: для снижения трафика и нагрузки на чтение из БД можно не тащить полный объект справочников, а забирать на фронте по необходимости. А тут хранить айдишники только
    // TODO: речь про персон, статусы, приоритеты

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
      status: status?.status(wsId),
      estimate: estimate,
      tasks: [],
      priority: priority?.priority(wsId),
      author: author?.member(wsId),
      assignee: assignee?.member(wsId),
      taskSource: ts,
      parent: parent,
      wsId: wsId,
    );
    _t.tasks = tasks?.map((t) => t.task(wsId: wsId, parent: _t)).toList() ?? [];
    return _t;
  }
}

extension TaskImportMapper on api.Task {
  TaskImport get taskImport => TaskImport(
        title: title ?? '??',
        description: description ?? '',
        taskSource: taskSource?.taskSourceImport,
      );
}
