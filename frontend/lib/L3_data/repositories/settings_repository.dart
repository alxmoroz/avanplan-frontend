// Copyright (c) 2021. Alexandr Moroz

import '../../L1_domain/entities/app_settings.dart';
import '../../L1_domain/entities/base.dart';
import '../../L3_data/models/app_settings.dart';
import '../../L3_data/repositories/hive_repository.dart';
import '../../extra/services.dart';

class SettingsRepository extends HiveRepo<AppSettings, AppSettingsHO> {
  SettingsRepository() : super(ECode.AppSettings, () => AppSettingsHO());

  Future<AppSettings> getOrCreate() async {
    final settingsList = await getAll();
    final settings = settingsList.isEmpty ? AppSettings(firstLaunch: true, model: null) : settingsList.first;

    // final oldVersion = settings.version;
    settings.version = packageInfo.version;
    await save(settings, null);

    return settings;
  }
}
