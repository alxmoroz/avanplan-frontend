// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as o_api;
import 'package:dio/dio.dart';

import '../../L1_domain/entities/user.dart';
import '../../L1_domain/repositories/abs_my_avatar_repo.dart';
import '../mappers/user.dart';
import '../services/api.dart';

class MyAvatarRepo extends AbstractMyAvatarRepo {
  o_api.MyAvatarApi get _api => avanplanApi.getMyAvatarApi();

  @override
  Future<User?> uploadAvatar(
    Stream<List<int>> Function() data,
    int length,
    String filename,
    DateTime lastModified,
  ) async {
    final multipartFile = MultipartFile.fromStream(
      data,
      length,
      filename: filename,
      headers: {
        'last-modified': [lastModified.toIso8601String()]
      },
    );

    final response = await _api.uploadAvatar(file: multipartFile);
    return response.data?.myUser(-1);
  }

  @override
  Future<User?> deleteAvatar() async {
    final response = await _api.deleteAvatar();
    return response.data?.myUser(-1);
  }
}
