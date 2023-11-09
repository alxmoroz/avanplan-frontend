// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/project_status.dart';
import '../../L1_domain/entities/workspace.dart';
import '../extra/services.dart';

extension WSStatusesUC on Workspace {
  Iterable<ProjectStatus> get defaultStatuses => [
        ProjectStatus(id: null, title: 'LOC.STATE_READY', position: 0, closed: false),
        ProjectStatus(id: null, title: 'LOC.STATUS_IN_PROGRESS', position: 1, closed: false),
        ProjectStatus(id: null, title: 'LOC.STATUS_IN_REVIEW', position: 2, closed: false),
        ProjectStatus(id: null, title: loc.state_closed, position: 4, closed: true),
      ];
}
