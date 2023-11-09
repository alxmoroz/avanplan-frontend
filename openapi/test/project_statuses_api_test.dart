import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for ProjectStatusesApi
void main() {
  final instance = Openapi().getProjectStatusesApi();

  group(ProjectStatusesApi, () {
    // Delete
    //
    //Future<bool> deleteStatus(int statusId, int wsId, int taskId, { int permissionTaskId }) async
    test('test deleteStatus', () async {
      // TODO
    });

    // Upsert
    //
    //Future<ProjectStatusGet> upsertStatus(int wsId, int taskId, ProjectStatusUpsert projectStatusUpsert, { int permissionTaskId }) async
    test('test upsertStatus', () async {
      // TODO
    });
  });
}
