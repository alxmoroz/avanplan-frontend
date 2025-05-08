// Copyright (c) 2024. Alexandr Moroz

import '../entities/local_auth.dart';
import '../entities/registration.dart';
import '../repositories/abs_auth_repo.dart';
import '../repositories/abs_network_repo.dart';

class AuthUC {
  AuthUC({
    required this.googleRepo,
    required this.appleRepo,
    required this.yandexRepo,
    required this.authAvanplanRepo,
    required this.networkRepo,
  }) : _currentRepo = authAvanplanRepo;

  final AbstractOAuthRepo googleRepo;
  final AbstractOAuthRepo appleRepo;
  final AbstractOAuthRepo yandexRepo;
  final AbstractAuthAvanplanRepo authAvanplanRepo;
  final AbstractNetworkRepo networkRepo;

  AbstractAuthRepo _currentRepo;

  void _updateOAuth(String token) => networkRepo.setOauthToken(token);

  Future<bool> _setToken(String token) async {
    await _currentRepo.setToken(token);
    _updateOAuth(token);
    return token.isNotEmpty;
  }

  Future<bool> refreshToken() async => await _setToken(await authAvanplanRepo.refreshToken());

  Future<LocalAuth> getLocalAuth() async {
    final la = await _currentRepo.getLocalAuth();
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

  Future<bool> _signInOAuth(AbstractOAuthRepo repo, {String? serverAuthCode}) async {
    _currentRepo = repo;
    return await _setToken(await repo.signIn(serverAuthCode: serverAuthCode));
  }

  Future<bool> googleIsAvailable() async => await googleRepo.signInIsAvailable();
  Future<bool> signInGoogle() async => await _signInOAuth(googleRepo);

  Future<bool> appleIsAvailable() async => await appleRepo.signInIsAvailable();
  Future<bool> signInApple() async => await _signInOAuth(appleRepo);

  Uri get yandexServerAuthCodeUri => yandexRepo.serverAuthCodeUri;
  Future<bool> signInYandex(String serverAuthCode) async => await _signInOAuth(yandexRepo, serverAuthCode: serverAuthCode);

  Future signOut({bool disconnect = false}) async {
    await _currentRepo.signOut(disconnect: disconnect);
    await _setToken('');
  }
}
