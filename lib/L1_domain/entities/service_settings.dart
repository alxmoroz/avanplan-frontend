// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';

class ServiceSettings extends RPersistable {
  ServiceSettings({
    required super.id,
    required this.frontendFlags,
    required this.lowStartThresholdDays,
    required this.estimateReliabilityDays,
    required this.riskThresholdDays,
  });

  final String frontendFlags;

  final int? lowStartThresholdDays;
  final int? riskThresholdDays;
  final int? estimateReliabilityDays;
}
