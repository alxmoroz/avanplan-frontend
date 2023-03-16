// Copyright (c) 2022. Alexandr Moroz

import '../entities/app_settings.dart';
import '../repositories/abs_settings_repo.dart';

class AppSettingsUC {
  AppSettingsUC(this.repo);

  final AbstractSettingsRepo repo;

  Future<AppSettings?> getSettings() async => await repo.getSettings();
}
