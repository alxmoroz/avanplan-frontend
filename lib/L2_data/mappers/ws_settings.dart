// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/ws_settings.dart';
import 'estimate_unit.dart';

extension WSSettingsMapper on SettingsGet {
  WSSettings settings(int wsId) => WSSettings(
        id: id,
        estimateUnit: estimateUnit?.unit(wsId),
        workspaceId: wsId,
      );
}
