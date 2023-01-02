// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/estimate.dart';
import '../../L1_domain/entities/person.dart';
import '../../L1_domain/entities/priority.dart';
import '../../L1_domain/entities/status.dart';
import '../../L1_domain/entities/workspace.dart';
import 'estimate.dart';
import 'person.dart';
import 'priority.dart';
import 'source.dart';
import 'status.dart';

extension WorkspaceMapper on api.WorkspaceGet {
  // TODO: сортируем тут только те списки, которые не редактируем в приложении на данный момент. Нужно перенести в контроллеры для редактирования
  List<Status> get _sortedStatuses => statuses.map((s) => s.status).sorted((s1, s2) => compareNatural('$s1', '$s2'));
  List<Priority> get _sortedPriorities => priorities.map((p) => p.priority).sorted((p1, p2) => compareNatural('$p1', '$p2'));
  List<Person> get _sortedPersons => persons.map((p) => p.person).sorted((p1, p2) => compareNatural('$p1', '$p2'));
  List<Estimate> get _sortedEstimates => estimates.map((e) => e.estimate).sorted((e1, e2) => compareNatural('$e1', '$e2'));

  // TODO: для гостевых ролей в памяти приложения доступна инфа, которая может быть конфиденц. Нужно не отдавать с бэка лишнее.
  // TODO: сделать отдельные эндпойнты с контролем прав на бэкенде

  Workspace get workspace => Workspace(
        id: id,
        code: code,
        description: description?.trim() ?? '',
        sources: sources.map((rt) => rt.source).toList(),
        persons: _sortedPersons,
        priorities: _sortedPriorities,
        statuses: _sortedStatuses,
        estimates: _sortedEstimates,
      );
}
