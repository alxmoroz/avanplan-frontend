// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/api_schema/base_upsert.dart';
import '../../L1_domain/entities/ew_status.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L3_app/extra/services.dart';

class TaskStatusesRepo extends AbstractApiRepo<EWStatus, BaseUpsert> {
  TasksApi get api => openAPI.getTasksApi();

  @override
  Future<List<EWStatus>> getAll() async => throw UnimplementedError();

  @override
  Future<EWStatus?> save(dynamic data) => throw UnimplementedError();

  @override
  Future<bool> delete(int id) => throw UnimplementedError();
}
