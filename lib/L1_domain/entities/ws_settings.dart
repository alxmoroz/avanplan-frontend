// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'estimate_unit.dart';

class WSSettings extends WSBounded {
  WSSettings({
    required super.id,
    required this.estimateUnit,
    required super.wsId,
  });

  final EstimateUnit? estimateUnit;
}
