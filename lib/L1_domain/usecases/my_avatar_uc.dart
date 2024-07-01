// Copyright (c) 2024. Alexandr Moroz

import '../../L1_domain/repositories/abs_my_avatar_repo.dart';
import '../entities/user.dart';

class MyAvatarUC {
  const MyAvatarUC(this.repo);

  final AbstractMyAvatarRepo repo;

  Future<User?> uploadAvatar(
    Stream<List<int>> Function() data,
    int length,
    String filename,
    DateTime lastModified,
  ) async =>
      await repo.uploadAvatar(data, length, filename, lastModified);

  Future<User?> deleteAvatar() async => await repo.deleteAvatar();
}
