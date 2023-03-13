// Copyright (c) 2022. Alexandr Moroz

import '../entities/app_settings.dart';
import '../repositories/abs_db_repo.dart';

class AppSettingsUC {
  AppSettingsUC(this.repo);

  final AbstractDBRepo<AbstractDBModel, AppSettings> repo;

  Future updateVersion(String version) async {
    final settings = await getSettings();
    settings.version = version;
    await repo.update(settings);
  }

  Future<AppSettings> getSettings() async => await repo.getOne() ?? AppSettings(firstLaunch: true);
}
