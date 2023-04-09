// Copyright (c) 2022. Alexandr Moroz

import '../entities/registration.dart';

abstract class AbstractRegistrationRepo {
  Future<bool> create(Registration registration, String password);
  Future<String> redeem(String token);
}
