// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/status.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../mappers/status.dart';
import '../services/api.dart';

class StatusRepo extends AbstractApiRepo<Status, Status> {
  o_api.StatusesApi get _api => openAPI.getStatusesApi();

  @override
  Future<Iterable<Status>> getAllWithWS(int wsId) async {
    final response = await _api.statusesV1WorkspacesWsIdStatusesGet(wsId: wsId);
    return response.data?.map((st) => st.status(wsId)) ?? [];
  }

  @override
  Future<Status?> save(Status data) async {
    final b = o_api.StatusUpsertBuilder()
      ..id = data.id
      ..code = data.code
      ..closed = data.closed;
    final response = await _api.statusesUpsert(
      wsId: data.wsId,
      statusUpsert: b.build(),
    );
    return response.data?.status(data.wsId);
  }

  @override
  Future<Status?> delete(Status data) async {
    final response = await _api.statusesDelete(statusId: data.id!, wsId: data.wsId);
    return response.data == true ? data : null;
  }
}
