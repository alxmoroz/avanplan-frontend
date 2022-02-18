// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/app_settings.dart';
import '../../L1_domain/repositories/abstract_auth_repo.dart';
import '../../L1_domain/repositories/abstract_db_repo.dart';

class AuthUC {
  AuthUC({required this.settingsRepo, required this.authRepo});

  final AbstractDBRepo<AbstractDBModel, AppSettings> settingsRepo;
  final AbstractAuthRepo authRepo;

  Future _setAccessToken(String accessToken) async {
    final settings = await settingsRepo.getOne();

    if (settings != null) {
      settings.accessToken = accessToken;
      await settingsRepo.update(settings);
      authRepo.setApiCredentials(settings.accessToken);
    }
  }

  Future<String> authorize({required String username, required String password}) async {
    final token = await authRepo.getApiAuthToken(username, password);
    _setAccessToken(token);
    return token;
  }

  Future updateApiCredentialsFromSettings() async {
    final settings = await settingsRepo.getOne();
    if (settings != null) {
      authRepo.setApiCredentials(settings.accessToken);
    }
  }

  Future logout() async {
    _setAccessToken('');
  }
}
