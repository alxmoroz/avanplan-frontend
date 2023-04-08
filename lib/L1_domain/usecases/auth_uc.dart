// Copyright (c) 2022. Alexandr Moroz

import '../../L2_data/services/api.dart';
import '../entities/local_auth.dart';
import '../repositories/abs_auth_repo.dart';
import '../repositories/abs_db_repo.dart';

class AuthUC {
  AuthUC({required this.localDBAuthRepo, required this.googleRepo, required this.appleRepo, required this.passwordRepo});
  Future<AuthUC> init() async => this;

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
    la.signinDate = token.isNotEmpty ? DateTime.now() : null;
    await localDBAuthRepo.update(la);
  }

  Future<bool> get hasLocalAuth async => (await _getToken()).isNotEmpty;

  Future updateOAuthToken() async => openAPI.setOAuthToken('OAuth2PasswordBearer', await _getToken());

  Future<bool> _signInWithToken(String token) async {
    await _setToken(token);
    await updateOAuthToken();
    return await hasLocalAuth;
  }

  Future<bool> _signIn(AbstractAuthRepo repo, {String? email, String? pwd, String? locale, bool? invited}) async {
    _currentRepo = repo;
    return await _signInWithToken(
      await repo.signIn(locale: locale, email: email, pwd: pwd, invited: invited),
    );
  }

  Future<bool> signInEmail({required String email, required String pwd}) async => await _signIn(passwordRepo, email: email, pwd: pwd);

  Future<bool> signInGoogleIsAvailable() async => await googleRepo.signInIsAvailable();
  Future<bool> signInGoogle(String locale, bool? invited) async => await _signIn(googleRepo, locale: locale, invited: invited);

  Future<bool> signInAppleIsAvailable() async => await appleRepo.signInIsAvailable();
  Future<bool> signInApple(String locale, bool? invited) async => await _signIn(appleRepo, locale: locale, invited: invited);

  static const _authCheckPeriod = Duration(hours: 12);
  Future<bool> refreshAuth() async {
    bool res = await hasLocalAuth;
    final signinDate = (await _getLocalAuth()).signinDate;
    if (signinDate == null || signinDate.add(_authCheckPeriod).isBefore(DateTime.now())) {
      res = await _signInWithToken(await passwordRepo.refreshToken());
    }
    return res;
  }

  Future signOut() async {
    await _currentRepo?.signOut();
    _setToken('');
    updateOAuthToken();
  }
}
