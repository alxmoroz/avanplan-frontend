// Copyright (c) 2021. Alexandr Moroz

import '../../L1_domain/entities/app_settings.dart';
import '../../L1_domain/entities/base.dart';
import '../../L1_domain/repositories/settings_repository.dart';
import '../../L3_data/models/app_settings.dart';
import '../../L3_data/repositories/hive_repository.dart';
import '../../extra/services.dart';

class SettingsRepo extends HiveRepo<AppSettings, AppSettingsHO> implements SettingsRepository {
  SettingsRepo() : super(ECode.AppSettings, () => AppSettingsHO());

  @override
  Future<AppSettings> getOrCreate() async {
    final settingsList = await getAll();
    final settings = settingsList.isEmpty ? AppSettings(firstLaunch: true, model: null) : settingsList.first;

    // final oldVersion = settings.version;
    settings.version = packageInfo.version;
    await save(settings, null);

    return settings;
  }

  @override
  Future<String> getApiAuthToken(String username, String password) async {
    String accessToken = '';

    final response = await openAPI.getAuthApi().getAuthToken(
          username: username,
          password: password,
        );

    if (response.statusCode == 200) {
      final token = response.data;
      if (token != null) {
        accessToken = token.accessToken;
      }
    }
    // TODO: обработка ошибок авторизации...
    return accessToken;
  }

  @override
  void setApiCredentials(String token) {
    // TODO: тоже самое нужно сделать при загрузке данных из локальной БД
    // TODO: вынести в отдельный метод для репозитория, где будет токен обрабатываться
    openAPI.setOAuthToken('OAuth2PasswordBearer', token);
  }
}
