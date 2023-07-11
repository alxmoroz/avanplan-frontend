// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'estimate_unit.dart';

class WSettings extends RPersistable {
  WSettings({
    required super.id,
    required this.estimateUnit,
  });

  final EstimateUnit? estimateUnit;
}
