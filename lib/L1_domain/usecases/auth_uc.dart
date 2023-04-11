// Copyright (c) 2022. Alexandr Moroz

import '../../L2_data/services/api.dart';
import '../entities/local_auth.dart';
import '../repositories/abs_auth_repo.dart';
import '../repositories/abs_db_repo.dart';

class AuthUC {
  AuthUC({required this.localDBAuthRepo, required this.googleRepo, required this.appleRepo, required this.emailRepo}) : _currentRepo = emailRepo;
  Future<AuthUC> init() async => this;

  final AbstractOAuthRepo googleRepo;
  final AbstractOAuthRepo appleRepo;
  final AbstractAuthAvanplanRepo emailRepo;
  final AbstractDBRepo<AbstractDBModel, LocalAuth> localDBAuthRepo;

  AbstractAuthRepo _currentRepo;

  Future<LocalAuth> _getLocalAuth() async => await localDBAuthRepo.getOne() ?? LocalAuth();
  Future<String> _getToken() async => (await _getLocalAuth()).accessToken;
  Future _setToken(String token) async {
    final la = await _getLocalAuth();
    la.accessToken = token;
    la.signinDate = token.isNotEmpty ? DateTime.now() : null;
    await localDBAuthRepo.update(la);
  }

  Future<bool> get hasLocalAuth async => (await _getToken()).isNotEmpty;

  Future updateOAuthToken() async => openAPI.setOAuthToken('OAuth2PasswordBearer', await _getToken());

  Future<bool> signInWithToken(String token) async {
    await _setToken(token);
    await updateOAuthToken();
    return await hasLocalAuth;
  }

  Future<bool> _signInOAuth(AbstractOAuthRepo repo, String? locale) async {
    _currentRepo = repo;
    return await signInWithToken(
      await repo.signIn(locale: locale),
    );
  }

  Future<bool> signInAvanplan(String email, String pwd) async {
    _currentRepo = emailRepo;
    return await signInWithToken(
      await emailRepo.signIn(email: email, pwd: pwd),
    );
  }

  Future<bool> googleIsAvailable() async => await googleRepo.signInIsAvailable();
  Future<bool> signInGoogle(String locale) async => await _signInOAuth(googleRepo, locale);

  Future<bool> appleIsAvailable() async => await appleRepo.signInIsAvailable();
  Future<bool> signInApple(String locale) async => await _signInOAuth(appleRepo, locale);

  static const _authCheckPeriod = Duration(hours: 12);
  Future<bool> refreshAuth() async {
    bool res = await hasLocalAuth;
    final signinDate = (await _getLocalAuth()).signinDate;
    if (signinDate == null || signinDate.add(_authCheckPeriod).isBefore(DateTime.now())) {
      res = await signInWithToken(await emailRepo.refreshToken());
    }
    return res;
  }

  Future signOut() async {
    await _currentRepo.signOut();
    _setToken('');
    updateOAuthToken();
  }
}
