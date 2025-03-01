// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as o_api;

import '../../L1_domain/entities/service_settings.dart';
import '../../L1_domain/repositories/abs_service_settings_repo.dart';
import '../mappers/service_settings.dart';
import '../services/api.dart';

class ServiceSettingsRepo extends AbstractServiceSettingsRepo {
  o_api.SettingsApi get api => avanplanApi.getSettingsApi();

  @override
  Future<ServiceSettings?> getSettings() async {
    final response = await api.settingsV1SettingsGet();
    return response.data?.settings;
  }
}
