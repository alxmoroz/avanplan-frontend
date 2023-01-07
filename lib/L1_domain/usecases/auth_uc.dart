// Copyright (c) 2022. Alexandr Moroz

import '../../L2_data/services/api.dart';
import '../entities/local_auth.dart';
import '../repositories/abs_api_auth_repo.dart';
import '../repositories/abs_db_repo.dart';

class AuthUC {
  AuthUC({required this.localDBAuthRepo, required this.googleRepo, required this.appleRepo, required this.passwordRepo});

  final AbstractAuthRepo googleRepo;
  final AbstractAuthRepo appleRepo;
  final AbstractAuthRepo passwordRepo;
  final AbstractDBRepo<AbstractDBModel, LocalAuth> localDBAuthRepo;

  AbstractAuthRepo? _currentRepo;

  Future<LocalAuth> _getLocalAuth() async => await localDBAuthRepo.getOne() ?? LocalAuth();
  Future<String> _getToken() async => (await _getLocalAuth()).accessToken;
  Future _setToken(String token) async {
    final la = await _getLocalAuth();
    la.accessToken = token;
    await localDBAuthRepo.update(la);
  }

  Future<bool> get hasLocalAuth async => (await _getToken()).isNotEmpty;

  Future updateOAuthToken() async => openAPI.setOAuthToken('OAuth2PasswordBearer', await _getToken());

  Future<bool> _signIn(AbstractAuthRepo repo, {String? username, String? password, String? locale}) async {
    _currentRepo = repo;
    await _setToken(await repo.signIn(locale: locale, username: username, password: password));
    await updateOAuthToken();
    return await hasLocalAuth;
  }

  Future<bool> signInWithPassword({required String username, required String password}) async =>
      await _signIn(passwordRepo, username: username, password: password);

  Future<bool> signInWithGoogle(String locale) async => await _signIn(googleRepo, locale: locale);

  Future<bool> signInWithApple(String locale) async => await _signIn(appleRepo, locale: locale);

  Future<bool> signInWithAppleIsAvailable() async => await appleRepo.signInIsAvailable();
  Future<bool> signInWithGoogleIsAvailable() async => await googleRepo.signInIsAvailable();

  Future signOut() async {
    await _currentRepo?.signOut();
    _setToken('');
    updateOAuthToken();
  }
}
