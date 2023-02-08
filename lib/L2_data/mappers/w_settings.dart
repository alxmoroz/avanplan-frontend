// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/ws_settings.dart';
import 'estimate_unit.dart';

extension WSettingsMapper on SettingsGet {
  WSettings settings(int wsId) => WSettings(
        id: id,
        estimateUnit: estimateUnit?.unit(wsId),
        wsId: wsId,
      );
}
