// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/ws_settings.dart';
import '../../L1_domain/repositories/abs_settings_repo.dart';
import '../mappers/w_settings.dart';
import '../services/api.dart';

class WSSettingsRepo extends AbstractSettingsRepo {
  o_api.SettingsApi get api => openAPI.getSettingsApi();

  @override
  Future<WSettings?> getSettings(int wsId) async {
    final response = await api.getSettingsV1SettingsGet(wsId: wsId);
    return response.data?.settings(wsId);
  }
}
