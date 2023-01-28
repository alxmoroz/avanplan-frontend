// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/ws_settings.dart';

abstract class AbstractApiSettingsRepo {
  Future<WSSettings?> getSettings(int wsId);
}
