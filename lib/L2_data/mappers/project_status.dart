// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/project_status.dart';

extension ProjectStatusMapper on ProjectStatusGet {
  ProjectStatus get projectStatus => ProjectStatus(
        id: id,
        title: title ?? '?',
        description: description ?? '',
        position: position,
        closed: closed ?? false,
      );
}
