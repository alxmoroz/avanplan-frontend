// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/api_schema/base_upsert.dart';
import '../../L1_domain/entities/status.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L3_app/extra/services.dart';

class TaskStatusesRepo extends AbstractApiRepo<Status, BaseUpsert> {
  TasksApi get api => openAPI.getTasksApi();

  @override
  Future<List<Status>> getAll() async => throw UnimplementedError();

  @override
  Future<Status?> save(dynamic data) => throw UnimplementedError();

  @override
  Future<bool> delete(int id) => throw UnimplementedError();
}
