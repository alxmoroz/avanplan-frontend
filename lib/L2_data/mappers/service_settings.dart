// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart';

import '../../L1_domain/entities/service_settings.dart';

extension ServiceSettingsMapper on AppSettingsGet {
  ServiceSettings get settings => ServiceSettings(
        id: id,
        lowStartThresholdDays: lowStartThresholdDays,
        riskThresholdDays: riskThresholdDays,
        estimateReliabilityDays: estimateReliabilityDays,
        frontendVersion: frontendVersion ?? '1.18.2103',
        frontendLtsVersion: frontendLtsVersion ?? '1.17.2081',
      );
}
