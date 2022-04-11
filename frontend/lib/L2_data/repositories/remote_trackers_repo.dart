// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/api_schema/remote_tracker.dart';
import '../../L1_domain/entities/goals/remote_tracker.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
// TODO: нарушение направления зависимостей. аналогично в похожих местах
import '../../L3_app/extra/services.dart';
import '../mappers/remote_tracker.dart';

class RemoteTrackersRepo extends AbstractApiRepo<RemoteTracker, RemoteTrackerUpsert> {
  IntegrationsTrackersApi get api => openAPI.getIntegrationsTrackersApi();

  @override
  Future<List<RemoteTracker>> getAll() async {
    final response = await api.getTrackersApiV1IntegrationsTrackersGet();

    final List<RemoteTracker> trackers = [];
    if (response.statusCode == 200) {
      for (RemoteTrackerSchemaGet t in response.data?.toList() ?? []) {
        trackers.add(t.tracker);
      }
    }
    return trackers;
  }

  @override
  Future<RemoteTracker?> save(RemoteTrackerUpsert data) async {
    //TODO: не учитываются возможные ошибки! Нет обработки 403 и т.п.
    final builder = RemoteTrackerSchemaUpsertBuilder()
      ..id = data.id
      ..remoteTrackerTypeId = data.typeId
      ..url = data.url
      ..loginKey = data.loginKey
      ..password = data.password
      ..description = data.description;

    final response = await api.upsertTrackerApiV1IntegrationsTrackersPost(remoteTrackerSchemaUpsert: builder.build());
    RemoteTracker? tracker;
    if (response.statusCode == 201) {
      tracker = response.data?.tracker;
    }
    return tracker;
  }

  @override
  Future<bool> delete(int id) async {
    final response = await api.deleteTrackerApiV1IntegrationsTrackersTrackerIdDelete(trackerId: id);
    return response.statusCode == 200 && response.data?.asNum == 1;
  }
}
