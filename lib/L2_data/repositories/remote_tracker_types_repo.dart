// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/api_schema/base_upsert.dart';
import '../../L1_domain/entities/goals/remote_tracker.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/remote_tracker_type.dart';

class RemoteTrackerTypesRepo extends AbstractApiRepo<RemoteTrackerType, BaseUpsert> {
  IntegrationsTrackersApi get api => openAPI.getIntegrationsTrackersApi();

  @override
  Future<List<RemoteTrackerType>> getAll() async {
    final response = await api.getTrackerTypesV1IntegrationsTrackersTypesGet();

    final List<RemoteTrackerType> types = [];
    if (response.statusCode == 200) {
      for (RemoteTrackerTypeSchemaGet rtt in response.data?.toList() ?? []) {
        types.add(rtt.type);
      }
    }
    return types;
  }

  @override
  Future<RemoteTrackerType?> save(dynamic data) => throw UnimplementedError();

  @override
  Future<bool> delete(int id) => throw UnimplementedError();
}
