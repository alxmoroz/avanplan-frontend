// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/project_status.dart';

extension ProjectStatusMapper on ProjectStatusGet {
  ProjectStatus projectStatus(int wsId) => ProjectStatus(
        id: id,
        wsId: wsId,
        projectId: projectId,
        title: title ?? '?',
        description: description ?? '',
        position: position,
        closed: closed ?? false,
      );
}
