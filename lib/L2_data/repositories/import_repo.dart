// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/remote_tracker.dart';
import '../../L1_domain/entities/task_import.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L1_domain/system/errors.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/task_import.dart';

// TODO: для всех подобных репозиториев: развязать узел зависимости от 3 уровня за счёт инициализации openApi в конструктор репы

class ImportRepo extends AbstractApiImportRepo {
  IntegrationsTasksApi get api => openAPI.getIntegrationsTasksApi();

  @override
  Future<List<TaskImport>> getRootTasks(int trackerId) async {
    final List<TaskImport> rootTasks = [];

    try {
      final response = await api.getRootTasksV1IntegrationsTasksGet(trackerId: trackerId);
      if (response.statusCode == 200) {
        for (TaskImportRemoteSchemaGet g in response.data?.toList() ?? []) {
          rootTasks.add(g.taskImport);
        }
      }
    } catch (e) {
      throw MTException(code: 'task_import_error_get_list', detail: e.toString());
    }

    return rootTasks;
  }

  @override
  Future<bool> importTasks(RemoteTracker tracker, List<String> rootTasksIds) async {
    final response = await api.importTasksV1IntegrationsTasksImportPost(
      trackerId: tracker.id,
      requestBody: BuiltList.from(rootTasksIds),
    );
    return response.statusCode == 200;
  }
}
