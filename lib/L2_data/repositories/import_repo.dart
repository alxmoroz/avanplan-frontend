// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/repositories/abs_import_repo.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class ImportRepo extends AbstractImportRepo {
  o_api.IntegrationsTasksApi get api => openAPI.getIntegrationsTasksApi();

  @override
  Future<Iterable<TaskRemote>> getProjectsList(Workspace ws, Source source) async {
    final response = await api.getProjectsListV1IntegrationsTasksGet(sourceId: source.id!, wsId: ws.id!);
    return response.data?.map((t) => t.taskRemote) ?? [];
  }

  @override
  Future<bool> startImport(Workspace ws, Source source, Iterable<TaskRemote> projects) async {
    final response = await api.startImportProjectsV1IntegrationsTasksStartImportPost(
      wsId: ws.id!,
      bodyStartImportProjectsV1IntegrationsTasksStartImportPost: (o_api.BodyStartImportProjectsV1IntegrationsTasksStartImportPostBuilder()
            ..projects = ListBuilder(
              projects.map<o_api.TaskRemote>((p) => (o_api.TaskRemoteBuilder()
                    ..title = p.title
                    ..taskSource = (o_api.TaskSourceBuilder()
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

  @override
  Future<bool> unlinkProject(Task project) async {
    final response = await api.unlinkV1IntegrationsTasksUnlinkPost(
      wsId: project.ws.id!,
      taskId: project.id!,
    );
    return response.data == true;
  }
}
