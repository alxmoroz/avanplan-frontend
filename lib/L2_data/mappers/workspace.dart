// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/person.dart';
import '../../L1_domain/entities/task_priority.dart';
import '../../L1_domain/entities/task_status.dart';
import '../../L1_domain/entities/workspace.dart';
import 'goal.dart';
import 'person.dart';
import 'remote_tracker.dart';
import 'task_priority.dart';
import 'task_status.dart';

extension WorkspaceMapper on WorkspaceSchemaGet {
  // TODO: сортируем тут только те списки, которые не редактируем в приложении на данный момент. Нужно перенести в контроллеры для редактирования
  List<TaskStatus> get _sortedStatuses {
    final List<TaskStatus> statuses = taskStatuses?.map((ts) => ts.status).toList() ?? [];
    statuses.sort((t1, t2) => t1.title.compareTo(t2.title));
    return statuses;
  }

  List<TaskPriority> get _sortedPriorities {
    final List<TaskPriority> priorities = taskPriorities?.map((tp) => tp.priority).toList() ?? [];
    priorities.sort((t1, t2) => t1.title.compareTo(t2.title));
    return priorities;
  }

  List<Person> get _sortedPersons {
    final List<Person> _persons = persons?.map((p) => p.person).toList() ?? [];
    _persons.sort((p1, p2) => '$p1'.compareTo('$p2'));
    return _persons;
  }

  Workspace get workspace => Workspace(
        id: id,
        title: title.trim(),
        remoteTrackers: remoteTrackers?.map((rt) => rt.tracker).toList() ?? [],
        persons: _sortedPersons,
        goals: goals?.map((g) => g.goal).toList() ?? [],
        taskPriorities: _sortedPriorities,
        taskStatuses: _sortedStatuses,
      );
}
