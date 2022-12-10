// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Estimate extends Titleable {
  Estimate({
    required super.id,
    required super.title,
    required this.value,
    required this.workspaceId,
  });

  final int value;
  final int workspaceId;
}
