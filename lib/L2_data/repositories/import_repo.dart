// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_source.dart';
import '../../L1_domain/repositories/abs_import_repo.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class ImportRepo extends AbstractImportRepo {
  o_api.IntegrationsTasksApi get api => openAPI.getIntegrationsTasksApi();

  @override
  Future<List<TaskRemote>> getRootTaskSources(Source source) async {
    final response = await api.getRootTasksV1IntegrationsTasksGet(sourceId: source.id!, wsId: source.wsId);
    return response.data?.map((t) => t.taskImport).toList() ?? [];
  }

  @override
  Future<bool> importTaskSources(Source source, Iterable<TaskSourceImport> tss) async {
    final tSchema = tss.map((ts) => (o_api.TaskSourceBuilder()
          ..code = ts.code
          ..rootCode = ts.rootCode
          ..keepConnection = ts.keepConnection
          ..updatedOn = ts.updatedOn)
        .build());
    final resp = await api.importTaskSourcesV1IntegrationsTasksImportPost(
      sourceId: source.id!,
      taskSource: BuiltList.from(tSchema),
      wsId: source.wsId,
    );
    return resp.data == true;
  }

  @override
  Future<bool> updateTaskSources(int wsId, Iterable<TaskSource> tss) async {
    final tSchema = tss.map((ts) => (o_api.TaskSourceUpsertBuilder()
          ..id = ts.id
          ..sourceId = ts.sourceId
          ..code = ts.code
          ..rootCode = ts.rootCode
          ..keepConnection = ts.keepConnection
          ..updatedOn = ts.updatedOn
          ..url = ts.urlString)
        .build());

    final resp = await api.updateTaskSourcesV1IntegrationsTasksUpdateTaskSourcesPost(taskSourceUpsert: BuiltList.from(tSchema), wsId: wsId);
    return resp.data == true;
  }
}
