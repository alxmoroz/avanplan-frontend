// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/app_settings.dart';
import '../../L2_data/repositories/db_repo.dart';
import '../../L3_app/extra/services.dart';
import '../models/app_settings.dart';

class SettingsRepo extends DBRepo<AppSettingsHO, AppSettings> {
  SettingsRepo() : super('AppSettings', () => AppSettingsHO());

  // TODO: Нарушение правила зависимостей. Есть зависимость от 3 уровня тут (сервисы)
  // TODO: это юзкейс! Репа не знает про версии и логику создания настроек! Вынести в сервисы или инит в мэйн контроллер в виде юзкейса.
  //  Возможно, отдельная репа для настроек и не понадобится вовсе тогда
  Future<AppSettings> setup() async {
    final settings = await getOne() ?? AppSettings(firstLaunch: true);

    // final oldVersion = settings.version;
    settings.version = packageInfo.version;
    await update(settings);

    return settings;
  }
}
