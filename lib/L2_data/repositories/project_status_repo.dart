// Copyright (c) 2022. Alexandr Moroz

// import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/project_status.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
// import '../mappers/project_status.dart';
// import '../services/api.dart';

class ProjectStatusRepo extends AbstractApiRepo<ProjectStatus, ProjectStatus> {
  // o_api.StatusesApi get _api => openAPI.getStatusesApi();

  @override
  Future<ProjectStatus?> save(ProjectStatus data) async {
    // final b = o_api.StatusUpsertBuilder()
    //   ..id = data.id
    //   ..code = data.code
    //   ..closed = data.closed
    //   ..allProjects = data.allProjects;
    // final response = await _api.upsertStatus(
    //   wsId: data.wsId,
    //   statusUpsert: b.build(),
    // );
    // return response.data?.status(data.wsId);
  }

  @override
  Future<ProjectStatus?> delete(ProjectStatus data) async {
    // final response = await _api.deleteStatus(statusId: data.id!, wsId: data.wsId);
    // return response.data == true ? data : null;
  }
}
