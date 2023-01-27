// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Priority extends Orderable {
  Priority({
    required super.id,
    required super.order,
    required super.code,
  });

  int workspaceId = -1;
}
