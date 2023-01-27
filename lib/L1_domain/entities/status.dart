// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Status extends Statusable {
  Status({
    required super.id,
    required super.code,
    required super.closed,
  });

  int workspaceId = -1;
}
