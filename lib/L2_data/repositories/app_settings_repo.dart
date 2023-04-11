// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/app_settings.dart';
import '../../L1_domain/repositories/abs_settings_repo.dart';
import '../mappers/app_settings.dart';
import '../services/api.dart';

class AppSettingsRepo extends AbstractSettingsRepo {
  o_api.SettingsApi get api => openAPI.getSettingsApi();

  @override
  Future<AppSettings?> getSettings() async {
    final response = await api.settingsV1SettingsGet();
    return response.data?.settings;
  }
}
