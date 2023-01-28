// Copyright (c) 2022. Alexandr Moroz

import '../entities/estimate_value.dart';
import '../entities/ws_settings.dart';
import '../repositories/abs_api_settings_repo.dart';
import '../repositories/abs_api_ws_repo.dart';

class WSSettingsUC {
  WSSettingsUC({
    required this.estValueRepo,
    required this.settingsRepo,
  });

  final AbstractApiWSRepo<EstimateValue> estValueRepo;
  final AbstractApiSettingsRepo settingsRepo;

  Future<List<EstimateValue>> getEstimateValues(int wsId) async => await estValueRepo.getAll(wsId);
  Future<WSSettings?> getSettings(int wsId) async => await settingsRepo.getSettings(wsId);
}
