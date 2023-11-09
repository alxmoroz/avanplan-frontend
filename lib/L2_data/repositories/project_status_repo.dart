// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/project_status.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../mappers/project_status.dart';
import '../services/api.dart';

class ProjectStatusRepo extends AbstractApiRepo<ProjectStatus, ProjectStatus> {
  o_api.ProjectStatusesApi get _api => openAPI.getProjectStatusesApi();

  @override
  Future<ProjectStatus?> save(ProjectStatus data) async {
    final b = o_api.ProjectStatusUpsertBuilder()
      ..id = data.id
      ..projectId = data.projectId
      ..title = data.title
      ..description = data.description
      ..closed = data.closed
      ..position = data.position;
    final response = await _api.upsertStatus(
      wsId: data.wsId,
      taskId: data.projectId,
      projectStatusUpsert: b.build(),
    );
    return response.data?.projectStatus(data.wsId);
  }

  @override
  Future<ProjectStatus?> delete(ProjectStatus data) async {
    final response = await _api.deleteStatus(statusId: data.id!, wsId: data.wsId, taskId: data.projectId);
    return response.data == true ? data : null;
  }
}
