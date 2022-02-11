// Copyright (c) 2022. Alexandr Moroz

import '../../extra/services.dart';
import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';
import 'base_uc.dart';

// TODO: нарушение направления зависимостей. Хоть и через гетИт, но есть зависимость от 3 уровня

extension AuthUC on AppSettings {
  SettingsRepository? get repo => hStorage.repoForName(classCode) as SettingsRepository;

  Future authorize({required String username, required String password}) async {
    accessToken = await repo?.getApiAuthToken(username, password) ?? '';
    await saveOnDisk();
    repo?.setApiCredentials(accessToken);
  }

  Future logout() async {
    accessToken = '';
    await saveOnDisk();
    repo?.setApiCredentials(accessToken);
  }
}
