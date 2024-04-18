// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/service_settings.dart';

abstract class AbstractServiceSettingsRepo {
  Future<ServiceSettings?> getSettings() async => throw UnimplementedError();
}
