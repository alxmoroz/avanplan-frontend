// Copyright (c) 2022. Alexandr Moroz

import '../entities/estimate_value.dart';
import '../entities/ws_settings.dart';
import '../repositories/abs_settings_repo.dart';
import '../repositories/abs_ws_repo.dart';

class WSSettingsUC {
  WSSettingsUC({
    required this.estValueRepo,
    required this.settingsRepo,
  });

  final AbstractWSRepo<EstimateValue> estValueRepo;
  final AbstractSettingsRepo settingsRepo;

  Future<Iterable<EstimateValue>> getEstimateValues(int wsId) async => await estValueRepo.getAll(wsId);
  Future<WSettings?> getSettings(int wsId) async => await settingsRepo.getSettings(wsId);
}
