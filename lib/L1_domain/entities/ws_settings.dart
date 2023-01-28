// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class WSSettings extends RPersistable {
  WSSettings({
    required super.id,
    required this.estimateUnit,
    required this.workspaceId,
  });

  final String estimateUnit;
  final int workspaceId;
}
