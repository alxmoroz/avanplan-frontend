// Copyright (c) 2024. Alexandr Moroz

import '../entities/local_auth.dart';
import '../entities/registration.dart';
import 'abs_db_repo.dart';

abstract class AbstractAuthRepo {
  AbstractAuthRepo(this._lsRepo);
  final AbstractLocalStorageRepo<AbstractDBModel, LocalAuth> _lsRepo;

  Future<LocalAuth> getLocalAuth() async => await _lsRepo.getOne() ?? LocalAuth();

  Future setToken(String token) async {
    final la = await getLocalAuth();
    la.accessToken = token;
    la.signinDate = token.isNotEmpty ? DateTime.now() : null;
    await _lsRepo.update((_) => true, la);
  }

  Future signOut({bool disconnect = false}) async => throw UnimplementedError();
  Future<bool> signInIsAvailable() async => throw UnimplementedError();
  Future<String> refreshToken() async => throw UnimplementedError();
}

abstract class AbstractOAuthRepo extends AbstractAuthRepo {
  AbstractOAuthRepo(super.lsRepo);

  Uri get serverAuthCodeUri => throw UnimplementedError();
  Future<String> signIn({String? serverAuthCode}) async => throw UnimplementedError();
}

abstract class AbstractAuthAvanplanRepo extends AbstractAuthRepo {
  AbstractAuthAvanplanRepo(super.lsRepo);

  Future<bool> postRegistrationRequest(RegistrationRequest rRequest, String password) async => throw UnimplementedError();
  Future<String> signInWithPassword({String? email, String? pwd}) async => throw UnimplementedError();
  Future<String> signInWithRegistration(String token) async => throw UnimplementedError();
}
