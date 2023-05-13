// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_source.dart';
import '../../L1_domain/repositories/abs_import_repo.dart';
import '../mappers/task.dart';
import '../services/api.dart';
import '../services/platform.dart';

class ImportRepo extends AbstractImportRepo {
  o_api.IntegrationsTasksApi get api => openAPI.getIntegrationsTasksApi();

  @override
  Future<List<TaskRemote>> getRootTaskSources(Source source) async {
    final response = await api.rootTasksV1IntegrationsTasksGet(sourceId: source.id!, wsId: source.wsId);
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
      platform: platformCode,
    );
    return resp.data == true;
  }

  @override
  Future<bool> unlinkTaskSources(int wsId, int taskId, Iterable<TaskSource> tss) async {
    if (tss.isNotEmpty) {
      final tSchema = tss.map((ts) => (o_api.TaskSourceUpsertBuilder()
            ..id = ts.id
            ..sourceId = ts.sourceId
            ..code = ts.code
            ..rootCode = ts.rootCode
            ..keepConnection = ts.keepConnection
            ..updatedOn = ts.updatedOn
            ..url = ts.urlString)
          .build());

      final resp = await api.unlinkTaskSourcesV1IntegrationsTasksUnlinkTaskSourcesPost(
        wsId: wsId,
        sourceId: tss.first.sourceId,
        taskSourceUpsert: BuiltList.from(tSchema),
      );
      return resp.data == true;
    }
    return false;
  }
}
