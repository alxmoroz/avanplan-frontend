// Copyright (c) 2022. Alexandr Moroz

import '../entities/local_settings.dart';
import '../repositories/abs_db_repo.dart';

class LocalSettingsUC {
  LocalSettingsUC(this.repo);

  final AbstractDBRepo<AbstractDBModel, LocalSettings> repo;

  Future<LocalSettings> settingsFromLaunch(String version) async {
    final settings = await repo.getOne() ?? LocalSettings();
    settings.version = version;
    settings.launchCount++;
    await repo.update(settings);
    return settings;
  }
}
