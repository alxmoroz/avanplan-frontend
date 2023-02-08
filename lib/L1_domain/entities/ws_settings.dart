// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'estimate_unit.dart';

class WSettings extends WSBounded {
  WSettings({
    required super.id,
    required this.estimateUnit,
    required super.wsId,
  });

  final EstimateUnit? estimateUnit;
}
