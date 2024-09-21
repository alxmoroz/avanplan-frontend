// Copyright (c) 2024. Alexandr Moroz

import '../entities/project_status.dart';
import 'abs_api_repo.dart';

abstract class AbstractProjectStatusesRepo extends AbstractApiRepo<ProjectStatus, ProjectStatus> {
  Future<int> statusTasksCount(int wsId, int projectId, int statusId) async => throw UnimplementedError();
}
