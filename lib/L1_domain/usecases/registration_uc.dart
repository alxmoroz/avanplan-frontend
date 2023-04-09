// Copyright (c) 2022. Alexandr Moroz

import '../entities/registration.dart';
import '../repositories/abs_registration_repo.dart';

class RegistrationUC {
  RegistrationUC(this.repo);
  Future<RegistrationUC> init() async => this;

  final AbstractRegistrationRepo repo;

  Future<bool> create(Registration registration, String password) async => await repo.create(registration, password);
  Future<String> redeem(String token) async => await repo.redeem(token);
}
