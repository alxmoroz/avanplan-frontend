// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/project_status.dart';
import '../../L1_domain/entities/workspace.dart';
import '../extra/services.dart';

extension WSStatusesUC on Workspace {
  Iterable<ProjectStatus> get defaultStatuses => [
        ProjectStatus(title: loc.status_default_ready_title, position: 0, closed: false),
        ProjectStatus(title: loc.status_default_in_progress_title, position: 1, closed: false),
        ProjectStatus(title: loc.status_default_in_review_title, position: 2, closed: false),
        ProjectStatus(title: loc.status_default_done_title, position: 3, closed: true),
      ];
}
