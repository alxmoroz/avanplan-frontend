// Copyright (c) 2024. Alexandr Moroz

import '../entities/user.dart';

abstract class AbstractMyAvatarRepo {
  Future<User?> uploadAvatar(
    Stream<List<int>> Function() data,
    int length,
    String filename,
    DateTime lastModified,
  ) =>
      throw UnimplementedError();

  Future<User?> deleteAvatar() => throw UnimplementedError();
}
