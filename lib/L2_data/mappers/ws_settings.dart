// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart';

import '../../L1_domain/entities/ws_settings.dart';
import 'estimate_unit.dart';

extension WSSettingsMapper on SettingsGet {
  WSSettings get settings => WSSettings(
        id: id,
        estimateUnit: estimateUnit?.unit,
      );
}
