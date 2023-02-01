// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class EstimateUnit extends Titleable {
  EstimateUnit({
    required super.id,
    required super.title,
    required super.description,
    required this.abbreviation,
    required this.wsId,
  });

  final String abbreviation;
  final int wsId;

  @override
  String toString() => '$abbreviation';
}
