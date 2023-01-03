// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/ws_settings.dart';

extension WSSettingsMapper on WSSettingsGet {
  WSSettings get settings => WSSettings(
        id: id,
        estimateUnit: estimateUnit ?? '',
      );
}
