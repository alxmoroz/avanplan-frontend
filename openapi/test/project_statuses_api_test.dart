// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart';
import 'package:test/test.dart';

/// tests for ProjectStatusesApi
void main() {
  final instance = Openapi().getProjectStatusesApi();

  group(ProjectStatusesApi, () {
    // Delete
    //
    //Future<bool> deleteStatus(int statusId, int wsId, int taskId) async
    test('test deleteStatus', () async {
      // TODO
    });

    // Status Tasks Count
    //
    //Future<int> statusTasksCount(int wsId, int taskId, int projectStatusId) async
    test('test statusTasksCount', () async {
      // TODO
    });

    // Upsert
    //
    //Future<ProjectStatusGet> upsertStatus(int wsId, int taskId, ProjectStatusUpsert projectStatusUpsert) async
    test('test upsertStatus', () async {
      // TODO
    });
  });
}
