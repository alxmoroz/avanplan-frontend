// Copyright (c) 2022. Alexandr Moroz

import '../entities/user.dart';
import '../repositories/abs_api_repo.dart';

abstract class AbstractApiUserRepo extends AbstractApiRepo<User> {
  Future<User?> getCurrentUser();
}
