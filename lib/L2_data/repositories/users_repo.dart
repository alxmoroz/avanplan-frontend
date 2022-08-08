// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/user.dart';
import '../../L1_domain/repositories/abs_user_repo.dart';
import '../../L1_domain/system/errors.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/user.dart';

class UsersRepo extends AbstractApiUserRepo {
  MyApi get api => openAPI.getMyApi();

  @override
  Future<User?> getCurrentUser() async {
    User? user;
    try {
      final response = await api.getMyAccountV1MyAccountGet();
      if (response.statusCode == 200) {
        user = response.data?.user;
      }
    } catch (e) {
      throw MTException(code: 'api_error_get_current_user', detail: e.toString());
    }
    return user;
  }

  @override
  Future<List<User>> getAll([dynamic query]) async => throw UnimplementedError();

  @override
  Future<User?> save(dynamic data) => throw UnimplementedError();

  @override
  Future<bool> delete(int? id) => throw UnimplementedError();
}
