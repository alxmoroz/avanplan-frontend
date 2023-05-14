// Copyright (c) 2022. Alexandr Moroz

import '../entities/service_settings.dart';
import '../repositories/abs_service_settings_repo.dart';

class ServiceSettingsUC {
  ServiceSettingsUC(this.repo);

  final AbstractServiceSettingsRepo repo;

  Future<ServiceSettings?> getSettings() async => await repo.getSettings();
}
