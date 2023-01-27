// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Estimate extends RPersistable {
  Estimate({
    required super.id,
    required this.value,
  });

  final int value;
  int workspaceId = -1;

  @override
  String toString() => '$value';
}
