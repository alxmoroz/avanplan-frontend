// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_ws_transfer_repo.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class WSTransferRepo extends AbstractWSTransferRepo {
  o_api.WSTransferApi get _api => openAPI.getWSTransferApi();

  @override
  Future<Iterable<Project>> projectTemplates(int wsId) async {
    final response = await _api.projectTemplates(wsId: wsId);
    return response.data?.map((t) => t.project) ?? [];
  }

  @override
  Future<TasksChanges?> createFromTemplate(int srcWsId, int srcProjectId, int dstWsId) async {
    final changes = (await _api.createFromTemplate(
      srcWsId: srcWsId,
      srcProjectId: srcProjectId,
      wsId: dstWsId,
    ))
        .data;
    return changes != null
        ? TasksChanges(
            changes.updatedTask.task(dstWsId),
            changes.affectedTasks.map((t) => t.task(dstWsId)),
          )
        : null;
  }

  @override
  Future<Iterable<Task>> sourcesForMove(int wsId) async {
    final response = await _api.sourcesForMoveTasks(wsId: wsId);
    return response.data?.map((t) => t.task(wsId)) ?? [];
  }

  @override
  Future<Iterable<Task>> destinationsForMove(int wsId, String taskType) async {
    final response = await _api.destinationsForMove(wsId: wsId, taskType: taskType);
    return response.data?.map((t) => t.task(wsId)) ?? [];
  }
}
