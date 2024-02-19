// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';

class ServiceSettings extends RPersistable {
  ServiceSettings({
    required super.id,
    required this.lowStartThresholdDays,
    required this.estimateReliabilityDays,
    required this.riskThresholdDays,
    required this.frontendVersion,
    required this.frontendLtsVersion,
  });

  final int? lowStartThresholdDays;
  final int? riskThresholdDays;
  final int? estimateReliabilityDays;

  final String frontendVersion;
  final String frontendLtsVersion;
}
