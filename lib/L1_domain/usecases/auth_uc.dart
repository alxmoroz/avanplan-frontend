// Copyright (c) 2022. Alexandr Moroz

import '../../L2_data/services/api.dart';
import '../entities/local_auth.dart';
import '../entities/registration.dart';
import '../repositories/abs_auth_repo.dart';
import '../repositories/abs_db_repo.dart';

class AuthUC {
  AuthUC({required this.localDBAuthRepo, required this.googleRepo, required this.appleRepo, required this.authAvanplanRepo})
      : _currentRepo = authAvanplanRepo;

  final AbstractOAuthRepo googleRepo;
  final AbstractOAuthRepo appleRepo;
  final AbstractAuthAvanplanRepo authAvanplanRepo;
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

  Future<bool> requestRegistration(RegistrationRequest registration, String password) async =>
      await authAvanplanRepo.postRegistrationRequest(registration, password);

  Future<bool> _signInWithToken(String token) async {
    await _setToken(token);
    await updateOAuthToken();
    return await hasLocalAuth;
  }

  Future<bool> signInWithPassword(String email, String pwd) async {
    _currentRepo = authAvanplanRepo;
    return await _signInWithToken(
      await authAvanplanRepo.signInWithPassword(email: email, pwd: pwd),
    );
  }

  Future<bool> signInWithRegistration(String token) async {
    _currentRepo = authAvanplanRepo;
    return await _signInWithToken(
      await authAvanplanRepo.signInWithRegistration(token),
    );
  }

  Future<bool> _signInOAuth(AbstractOAuthRepo repo) async {
    _currentRepo = repo;
    return await _signInWithToken(
      await repo.signIn(),
    );
  }

  Future<bool> googleIsAvailable() async => await googleRepo.signInIsAvailable();
  Future<bool> signInGoogle() async => await _signInOAuth(googleRepo);

  Future<bool> appleIsAvailable() async => await appleRepo.signInIsAvailable();
  Future<bool> signInApple() async => await _signInOAuth(appleRepo);

  static const _authCheckPeriod = Duration(hours: 12);

  Future<bool> needRefreshAuth() async {
    final signinDate = (await _getLocalAuth()).signinDate;
    return signinDate == null || signinDate.add(_authCheckPeriod).isBefore(DateTime.now());
  }

  Future<bool> refreshAuth() async => await _signInWithToken(await authAvanplanRepo.refreshToken());

  Future signOut() async {
    await _currentRepo.signOut();
    _setToken('');
    updateOAuthToken();
  }
}
