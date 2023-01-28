// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class EstimateValue extends Titleable {
  EstimateValue({
    required super.id,
    required super.title,
    required super.description,
    required this.value,
    required this.workspaceId,
  });

  final int value;
  final int workspaceId;

  @override
  String toString() => '$value';
}
