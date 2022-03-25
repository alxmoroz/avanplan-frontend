// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/repositories/abs_auth_repo.dart';
import 'settings_uc.dart';

class AuthUC {
  AuthUC({required this.settingsUC, required this.authRepo});

  final SettingsUC settingsUC;
  final AbstractAuthRepo authRepo;

  Future<bool> authorize({required String username, required String password}) async {
    final token = await authRepo.getApiAuthToken(username, password);
    authRepo.setApiCredentials(token);
    settingsUC.updateAccessToken(token);
    return token.isNotEmpty;
  }

  Future setApiCredentialsFromSettings() async {
    final token = await settingsUC.getAccessToken();
    authRepo.setApiCredentials(token);
  }

  Future logout() async {
    authRepo.setApiCredentials('');
    settingsUC.updateAccessToken('');
  }
}
