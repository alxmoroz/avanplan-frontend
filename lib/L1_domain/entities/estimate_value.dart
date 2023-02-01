// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class EstimateValue extends Titleable {
  EstimateValue({
    required super.id,
    required super.title,
    required super.description,
    required this.value,
    required this.wsId,
  });

  final int value;
  final int wsId;

  @override
  String toString() => '$value';
}
