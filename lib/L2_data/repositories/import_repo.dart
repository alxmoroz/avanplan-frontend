// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/task_import.dart' as ti;
import '../../L1_domain/repositories/abs_import_repo.dart';
import '../../L1_domain/system/errors.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/task_import.dart';

// TODO: для всех подобных репозиториев: развязать узел зависимости от 3 уровня за счёт инициализации openApi в конструктор репы

class ImportRepo extends AbstractApiImportRepo {
  IntegrationsTasksApi get api => openAPI.getIntegrationsTasksApi();

  @override
  Future<List<ti.TaskImport>> getRootTasks(int srcId) async {
    final List<ti.TaskImport> rootTasks = [];
    try {
      final response = await api.getRootTasksV1IntegrationsTasksGet(sourceId: srcId);
      if (response.statusCode == 200) {
        for (TaskImport t in response.data?.toList() ?? []) {
          rootTasks.add(t.taskImport);
        }
      }
    } catch (e) {
      throw MTException(code: 'task_import_title_error_get_list', detail: e.toString());
    }

    return rootTasks;
  }

  @override
  Future<bool> importTasks(Source src, List<String> codes) async {
    final response = await api.importTasksV1IntegrationsTasksImportPost(
      sourceId: src.id,
      requestBody: BuiltList.from(codes),
    );
    return response.statusCode == 200;
  }
}
