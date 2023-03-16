// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/app_settings.dart';

abstract class AbstractSettingsRepo {
  Future<AppSettings?> getSettings();
}
