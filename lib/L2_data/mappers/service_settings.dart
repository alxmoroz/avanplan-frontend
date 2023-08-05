// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/service_settings.dart';

extension ServiceSettingsMapper on AppSettingsGet {
  ServiceSettings get settings => ServiceSettings(
        id: id,
        frontendFlags: frontendFlags ?? '',
        lowStartThresholdDays: lowStartThresholdDays,
        riskThresholdDays: riskThresholdDays,
        estimateReliabilityDays: estimateReliabilityDays,
      );
}
