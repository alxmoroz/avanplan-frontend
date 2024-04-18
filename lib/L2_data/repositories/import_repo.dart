// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_import_repo.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class ImportRepo extends AbstractImportRepo {
  o_api.SourcesApi get api => openAPI.getSourcesApi();

  @override
  Future<Iterable<ProjectRemote>> getProjectsList(int wsId, int sourceId) async {
    final response = await api.getProjects(wsId: wsId, sourceId: sourceId);
    return response.data?.map((t) => t.taskImport) ?? [];
  }

  @override
  Future<bool> import(int wsId, int sourceId, Iterable<ProjectRemote> projects) async {
    final response = await api.startImport(
      wsId: wsId,
      sourceId: sourceId,
      bodyStartImport: (o_api.BodyStartImportBuilder()
            ..projects = ListBuilder(
              projects.map<o_api.TaskRemote>((p) => (o_api.TaskRemoteBuilder()
                    ..title = p.title
                    ..taskSource = (o_api.TaskSourceBuilder()
                      ..sourceId = sourceId
                      ..url = p.taskSource?.urlString
                      ..code = p.taskSource?.code
                      ..rootCode = p.taskSource?.rootCode
                      ..keepConnection = p.taskSource?.keepConnection
                      ..updatedOn = p.taskSource?.updatedOn))
                  .build()),
            ))
          .build(),
    );
    return response.data == true;
  }
}
