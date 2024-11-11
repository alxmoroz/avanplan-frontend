// Copyright (c) 2022. Alexandr Moroz

import '../entities/local_app_settings.dart';
import '../repositories/abs_db_repo.dart';

class LocalSettingsUC {
  LocalSettingsUC(this.repo);

  final AbstractDBRepo<AbstractDBModel, LocalAppSettings> repo;

  Future<LocalAppSettings> settings() async => await repo.getOne() ?? LocalAppSettings();

  Future<LocalAppSettings> updateSettingsFromLaunch(String version) async {
    final settings = await repo.getOne() ?? LocalAppSettings();
    settings.version = version;
    settings.launchCount++;
    await repo.update(settings);
    return settings;
  }

  Future<LocalAppSettings> setDate(String code, DateTime? date) async {
    final settings = await repo.getOne() ?? LocalAppSettings();
    if (date != null) {
      settings.setDate(code, date);
    } else {
      settings.removeDate(code);
    }

    await repo.update(settings);
    return settings;
  }

  Future<LocalAppSettings> setString(String code, String? string) async {
    final settings = await repo.getOne() ?? LocalAppSettings();
    if (string != null) {
      settings.setString(code, string);
    } else {
      settings.removeString(code);
    }

    await repo.update(settings);
    return settings;
  }
}
