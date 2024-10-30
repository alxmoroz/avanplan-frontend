// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_relation.dart';
import '../../L1_domain/repositories/abs_ws_relations_repo.dart';
import '../mappers/task.dart';
import '../mappers/task_relation.dart';
import '../services/api.dart';

class WSRelationsRepo extends AbstractWSRelationsRepo {
  o_api.WSRelationsApi get _api => openAPI.getWSRelationsApi();

  @override
  Future<TaskRelation?> save(TaskRelation data) async {
    final response = await _api.upsertRelation(
        wsId: data.wsId,
        taskId: data.srcId,
        taskRelationUpsert: (o_api.TaskRelationUpsertBuilder()
              ..id = data.id
              ..srcId = data.srcId
              ..dstId = data.dstId
              ..type = data.type)
            .build());
    return response.data?.relation(data.wsId);
  }

  @override
  Future<TaskRelation?> delete(TaskRelation data) async {
    final response = await _api.deleteRelation(
      wsId: data.wsId,
      taskId: data.srcId,
      relationId: data.id!,
    );
    return response.data == true ? data : null;
  }

  @override
  Future<Iterable<Task>> sourcesForRelations(int wsId) async {
    final data = (await _api.sourcesForRelations(wsId: wsId)).data;
    return data?.map((t) => t.task(wsId)) ?? [];
  }
}
