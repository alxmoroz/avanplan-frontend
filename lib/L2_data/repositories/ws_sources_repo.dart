// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/source_type.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_ws_sources_repo.dart';
import '../mappers/source.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class WSSourcesRepo extends AbstractWSSourcesRepo {
  o_api.WSSourcesApi get _api => openAPI.getWSSourcesApi();

  @override
  Future<Source?> save(Source data) async {
    final b = o_api.SourceUpsertBuilder()
      ..id = data.id
      ..type = data.typeCode
      ..url = data.url
      ..apiKey = data.apiKey
      ..username = data.username
      ..password = data.password
      ..description = data.description;

    final response = await _api.upsertSource(
      wsId: data.wsId,
      sourceUpsert: b.build(),
    );
    return response.data?.source(data.wsId);
  }

  @override
  Future<Source?> delete(Source data) async {
    final response = await _api.deleteSource(sourceId: data.id!, wsId: data.wsId);
    return response.data == true ? data : null;
  }

  @override
  Future<bool> checkConnection(Source s) async {
    try {
      final response = await _api.checkConnection(sourceId: s.id!, wsId: s.wsId);
      return response.data == true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> requestType(SourceType st, int wsId) async {
    final response = await _api.requestType(bodyRequestType: (o_api.BodyRequestTypeBuilder()..code = st.code).build(), wsId: wsId);
    return response.data == true;
  }

  @override
  Future<Iterable<ProjectRemote>> getProjectsList(int wsId, int sourceId) async {
    final response = await _api.getProjects(wsId: wsId, sourceId: sourceId);
    return response.data?.map((t) => t.taskImport) ?? [];
  }

  @override
  Future<bool> import(int wsId, int sourceId, Iterable<ProjectRemote> projects) async {
    final response = await _api.startImport(
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
