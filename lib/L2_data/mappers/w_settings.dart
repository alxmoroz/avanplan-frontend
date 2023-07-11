// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/ws_settings.dart';
import 'estimate_unit.dart';

extension WSettingsMapper on SettingsGet {
  WSettings get settings => WSettings(
        id: id,
        estimateUnit: estimateUnit?.unit,
      );
}
