// Copyright (c) 2022. Alexandr Moroz

import '../entities/user.dart';
import '../repositories/abs_user_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class UsersUC {
  UsersUC({required this.repo});

  final AbstractApiUserRepo repo;

  Future<User?> getCurrentUser() async => await repo.getCurrentUser();
}
