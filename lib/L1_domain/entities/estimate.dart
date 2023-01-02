// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Estimate extends RPersistable {
  Estimate({
    required super.id,
    required this.unit,
    required this.value,
    required this.workspaceId,
  });

  final int value;
  final String unit;
  final int workspaceId;
}
