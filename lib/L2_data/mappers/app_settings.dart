// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/app_settings.dart';

extension AppSettingsMapper on AppSettingsGet {
  AppSettings get settings => AppSettings(
        id: id,
        frontendFlags: frontendFlags ?? '',
      );
}
