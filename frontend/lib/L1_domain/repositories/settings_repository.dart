// Copyright (c) 2021. Alexandr Moroz

import '../entities/app_settings.dart';
import '../entities/base.dart';
import 'database_repository.dart';

abstract class SettingsRepository<E extends BaseEntity, M extends DBModel> {
  Future<AppSettings> getOrCreate();
  Future<String> getApiAuthToken(String username, String password);
  void setApiCredentials(String token);
}
