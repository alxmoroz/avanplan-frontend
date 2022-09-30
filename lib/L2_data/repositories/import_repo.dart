// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_source.dart';
import '../../L1_domain/repositories/abs_import_repo.dart';
import '../../L1_domain/system/errors.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/task.dart';

// TODO: для всех подобных репозиториев: развязать узел зависимости от 3 уровня за счёт инициализации openApi в конструктор репы

class ImportRepo extends AbstractApiImportRepo {
  o_api.IntegrationsTasksApi get api => openAPI.getIntegrationsTasksApi();

  @override
  Future<List<TaskImport>> getRootTaskSources(int srcId) async {
    final List<TaskImport> rootTasks = [];
    try {
      final response = await api.getRootTasksV1IntegrationsTasksGet(sourceId: srcId);
      if (response.statusCode == 200) {
        for (o_api.Task t in response.data?.toList() ?? []) {
          rootTasks.add(t.taskImport);
        }
      }
    } catch (e) {
      throw MTException(code: 'import_title_error_get_list', detail: e.toString());
    }

    return rootTasks;
  }

  @override
  Future<bool> importTaskSources(int? srcId, Iterable<TaskSourceImport> tss) async {
    if (srcId == null) {
      return false;
    }

    final tSchema = tss.map((ts) => (o_api.TaskSourceBuilder()
          ..code = ts.code
          ..rootCode = ts.rootCode
          ..keepConnection = ts.keepConnection)
        .build());
    final response = await api.importTaskSourcesV1IntegrationsTasksImportPost(
      sourceId: srcId,
      taskSource: BuiltList.from(tSchema),
    );
    return response.statusCode == 200;
  }

  @override
  Future<bool> updateTaskSources(Iterable<TaskSource> tss) async {
    final tSchema = tss.map((ts) => (o_api.TaskSourceUpsertBuilder()
          ..id = ts.id
          ..sourceId = ts.source.id
          ..code = ts.code
          ..rootCode = ts.rootCode
          ..keepConnection = ts.keepConnection
          ..url = ts.uri.toString())
        .build());

    final response = await api.updateTaskSourcesV1IntegrationsTasksUpdateTaskSourcesPost(
      taskSourceUpsert: BuiltList.from(tSchema),
    );
    return response.statusCode == 200;
  }
}
