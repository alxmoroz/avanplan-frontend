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

  void _updateOAuth(String token) => openAPI.setOAuthToken('OAuth2PasswordBearer', token);

  Future<bool> _setToken(String token) async {
    final la = await getLocalAuth();
    la.accessToken = token;
    la.signinDate = token.isNotEmpty ? DateTime.now() : null;
    await localDBAuthRepo.update(la);
    _updateOAuth(token);
    return token.isNotEmpty;
  }

  Future<bool> refreshToken() async => await _setToken(await authAvanplanRepo.refreshToken());

  Future<LocalAuth> getLocalAuth() async {
    final la = await localDBAuthRepo.getOne() ?? LocalAuth();
    _updateOAuth(la.accessToken);
    return la;
  }

  Future<bool> requestRegistration(RegistrationRequest registration, String password) async =>
      await authAvanplanRepo.postRegistrationRequest(registration, password);

  Future<bool> signInWithPassword(String email, String pwd) async {
    _currentRepo = authAvanplanRepo;
    return await _setToken(
      await authAvanplanRepo.signInWithPassword(email: email, pwd: pwd),
    );
  }

  Future<bool> signInWithRegistration(String token) async {
    _currentRepo = authAvanplanRepo;
    return await _setToken(await authAvanplanRepo.signInWithRegistration(token));
  }

  Future<bool> _signInOAuth(AbstractOAuthRepo repo) async {
    _currentRepo = repo;
    return await _setToken(await repo.signIn());
  }

  Future<bool> googleIsAvailable() async => await googleRepo.signInIsAvailable();
  Future<bool> signInGoogle() async => await _signInOAuth(googleRepo);

  Future<bool> appleIsAvailable() async => await appleRepo.signInIsAvailable();
  Future<bool> signInApple() async => await _signInOAuth(appleRepo);

  Future signOut() async {
    await _currentRepo.signOut();
    _setToken('');
  }
}
