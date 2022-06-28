// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/repositories/abs_auth_repo.dart';
import '../entities/local_auth.dart';
import '../repositories/abs_db_repo.dart';

class AuthUC {
  AuthUC({required this.authRepo, required this.localAuthRepo});

  final AbstractAuthRepo authRepo;
  final AbstractDBRepo<AbstractDBModel, LocalAuth> localAuthRepo;

  Future<bool> authorize({required String username, required String password}) async {
    final token = await authRepo.getApiAuthToken(username, password);
    authRepo.setApiCredentials(token);
    _updateAccessToken(token);
    return token.isNotEmpty;
  }

  Future<LocalAuth> _getLocalAuth() async => await localAuthRepo.getOne() ?? LocalAuth();

  Future _updateAccessToken(String accessToken) async {
    final la = await _getLocalAuth();
    la.accessToken = accessToken;
    await localAuthRepo.update(la);
  }

  Future<String> _getLocalAccessToken() async => (await _getLocalAuth()).accessToken;

  Future setApiCredentialsFromLocalAuth() async => authRepo.setApiCredentials(await _getLocalAccessToken());

  Future<bool> isLocalAuthorized() async => (await _getLocalAccessToken()).isNotEmpty;

  Future logout() async {
    authRepo.setApiCredentials('');
    _updateAccessToken('');
  }
}
