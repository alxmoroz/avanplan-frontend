// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/app_settings.dart';
import '../../L1_domain/repositories/abs_db_repo.dart';

class SettingsUC {
  SettingsUC({required this.settingsRepo});

  final AbstractDBRepo<AbstractDBModel, AppSettings> settingsRepo;

  Future updateVersion(String version) async {
    final settings = await getSettings();
    settings.version = version;
    await settingsRepo.update(settings);
  }

  Future<String> getAccessToken() async {
    return (await getSettings()).accessToken;
  }

  Future updateAccessToken(String accessToken) async {
    final settings = await getSettings();
    settings.accessToken = accessToken;
    await settingsRepo.update(settings);
  }

  Future<AppSettings> getSettings() async {
    return await settingsRepo.getOne() ?? AppSettings(firstLaunch: true);
  }
}
