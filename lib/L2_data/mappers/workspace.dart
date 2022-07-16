// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/person.dart';
import '../../L1_domain/entities/priority.dart';
import '../../L1_domain/entities/status.dart';
import '../../L1_domain/entities/workspace.dart';
import 'person.dart';
import 'priority.dart';
import 'remote_tracker.dart';
import 'status.dart';
import 'task.dart';

extension WorkspaceMapper on WorkspaceSchemaGet {
  // TODO: сортируем тут только те списки, которые не редактируем в приложении на данный момент. Нужно перенести в контроллеры для редактирования
  List<Status> get _sortedStatuses {
    final List<Status> _statuses = statuses?.map((s) => s.status).toList() ?? [];
    _statuses.sort((t1, t2) => t1.title.compareTo(t2.title));
    return _statuses;
  }

  List<Priority> get _sortedPriorities {
    final List<Priority> _priorities = priorities?.map((p) => p.priority).toList() ?? [];
    _priorities.sort((t1, t2) => t1.title.compareTo(t2.title));
    return _priorities;
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
        tasks: tasks?.map((t) => t.task).toList() ?? [],
        priorities: _sortedPriorities,
        statuses: _sortedStatuses,
      );
}
