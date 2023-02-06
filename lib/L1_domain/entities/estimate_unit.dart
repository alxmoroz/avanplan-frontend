// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class EstimateUnit extends Titleable {
  EstimateUnit({
    required super.id,
    required super.title,
    required super.description,
    required this.code,
    required this.wsId,
  });

  final String code;
  final int wsId;

  @override
  String toString() => '$code';
}
