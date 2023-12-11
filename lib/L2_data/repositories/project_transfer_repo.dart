// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_project_transfer_repo.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class ProjectTransferRepo extends AbstractProjectTransferRepo {
  o_api.TransferApi get api => openAPI.getTransferApi();

  @override
  Future<Iterable<Project>> getProjectTemplates(int wsId) async {
    final response = await api.projectTemplates(wsId: wsId);
    return response.data?.map((t) => t.project) ?? [];
  }

  @override
  Future<TasksChanges?> transfer(int srcWsId, int srcProjectId, int dstWsId) async {
    final changes = (await api.transferProject(
      srcWsId: srcWsId,
      srcProjectId: srcProjectId,
      wsId: dstWsId,
    ))
        .data;
    return TasksChanges(
      changes?.updatedTask.task(dstWsId),
      changes?.affectedTasks.map((t) => t.task(dstWsId)) ?? [],
    );
  }
}
