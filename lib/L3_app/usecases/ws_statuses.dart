// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/status.dart';
import '../../L1_domain/entities/workspace.dart';
import '../extra/services.dart';

extension WSStatusesUC on Workspace {
  Iterable<Status> get statuses => statusesController.statuses(id!);
  Iterable<Status> get _allProjectStatuses => statuses.where((st) => st.allProjects);
  Iterable<Status> get defaultStatuses => _allProjectStatuses.isNotEmpty ? _allProjectStatuses : statuses;
  Status? status(int statusId) => statusesController.status(id!, statusId);
}
