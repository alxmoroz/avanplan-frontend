// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class EstimateUnit extends Titleable {
  EstimateUnit({
    required super.id,
    required super.title,
    required super.description,
    required this.abbreviation,
    required this.workspaceId,
  });

  final String abbreviation;
  final int workspaceId;

  @override
  String toString() => '$abbreviation';
}
