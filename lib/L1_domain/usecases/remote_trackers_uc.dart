// Copyright (c) 2022. Alexandr Moroz

import '../api_schema/base_upsert.dart';
import '../api_schema/remote_tracker_upsert.dart';
import '../entities/remote_tracker.dart';
import '../repositories/abs_api_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class RemoteTrackersUC {
  RemoteTrackersUC({required this.repo});

  final AbstractApiRepo<RemoteTracker, RemoteTrackerUpsert, BaseSchema> repo;

  Future<RemoteTracker?> save(RemoteTrackerUpsert data) async {
    RemoteTracker? tracker;
    // TODO: внутр. exception - валидация...
    final login = data.login?.trim() ?? '';
    final apiKey = data.apiKey?.trim() ?? '';
    if (data.url.trim().isNotEmpty && (login.isNotEmpty || apiKey.isNotEmpty)) {
      tracker = await repo.save(data);
    }
    return tracker;
  }

  Future<RemoteTracker?> delete({required RemoteTracker tracker}) async {
    final deletedRows = await repo.delete(tracker.id);
    // TODO: внутр. exception
    if (deletedRows) {
      tracker.deleted = true;
    }
    return tracker;
  }
}

class RemoteTrackerTypesUC {
  RemoteTrackerTypesUC({required this.repo});

  final AbstractApiRepo<RemoteTrackerType, dynamic, dynamic> repo;

  Future<List<RemoteTrackerType>> getAll() async {
    return await repo.getAll();
  }
}
