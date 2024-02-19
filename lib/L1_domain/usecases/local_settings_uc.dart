// Copyright (c) 2022. Alexandr Moroz

import '../entities/local_settings.dart';
import '../repositories/abs_db_repo.dart';

class LocalSettingsUC {
  LocalSettingsUC(this.repo);

  final AbstractDBRepo<AbstractDBModel, LocalSettings> repo;

  Future<LocalSettings> settings() async => await repo.getOne() ?? LocalSettings();

  Future<LocalSettings> updateSettingsFromLaunch(String version) async {
    final settings = await repo.getOne() ?? LocalSettings();
    settings.version = version;
    settings.launchCount++;
    await repo.update(settings);
    return settings;
  }

  Future<LocalSettings> setAppUpgradeProposalDate(DateTime? date) async {
    final settings = await repo.getOne() ?? LocalSettings();
    if (date != null) {
      settings.setDate(LSDateCode.APP_UPGRADE_PROPOSAL, date);
    } else {
      settings.removeDate(LSDateCode.APP_UPGRADE_PROPOSAL);
    }

    await repo.update(settings);
    return settings;
  }
}
