// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/workspace.dart';

extension WorkspaceMapper on api.WorkspaceGet {
  Workspace get workspace => Workspace(
        id: id,
        title: title,
        description: description?.trim() ?? '',
        // sources: sources.map((rt) => rt.source).toList(),
        // persons: _sortedPersons,
        // priorities: _sortedPriorities,
        // statuses: _sortedStatuses,
        // estimates: _sortedEstimates,

        // settings: settings?.settings,
      );
}
