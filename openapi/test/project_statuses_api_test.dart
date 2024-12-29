import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for ProjectStatusesApi
void main() {
  final instance = Openapi().getProjectStatusesApi();

  group(ProjectStatusesApi, () {
    // Delete
    //
    //Future<bool> deleteStatus_1(int statusId, int wsId, int taskId) async
    test('test deleteStatus_1', () async {
      // TODO
    });

    // Status Tasks Count
    //
    //Future<int> statusTasksCount_1(int wsId, int taskId, int projectStatusId) async
    test('test statusTasksCount_1', () async {
      // TODO
    });

    // Upsert
    //
    //Future<ProjectStatusGet> upsertStatus_1(int wsId, int taskId, ProjectStatusUpsert projectStatusUpsert) async
    test('test upsertStatus_1', () async {
      // TODO
    });
  });
}
