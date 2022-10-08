// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/person.dart';
import '../../L1_domain/entities/priority.dart';
import '../../L1_domain/entities/status.dart';
import '../../L1_domain/entities/workspace.dart';
import 'person.dart';
import 'priority.dart';
import 'source.dart';
import 'status.dart';

extension WorkspaceMapper on api.WorkspaceGet {
  // TODO: сортируем тут только те списки, которые не редактируем в приложении на данный момент. Нужно перенести в контроллеры для редактирования
  List<Status> get _sortedStatuses => statuses.map((s) => s.status).sorted((t1, t2) => compareNatural(t1.title, t2.title));

  List<Priority> get _sortedPriorities => priorities.map((p) => p.priority).sorted((t1, t2) => compareNatural(t1.title, t2.title));

  List<Person> get _sortedPersons => persons.map((p) => p.person).sorted((p1, p2) => compareNatural('$p1', '$p2'));

  Workspace get workspace => Workspace(
        id: id,
        title: title.trim(),
        description: description?.trim() ?? '',
        sources: sources.map((rt) => rt.source).toList(),
        persons: _sortedPersons,
        priorities: _sortedPriorities,
        statuses: _sortedStatuses,
      );
}
