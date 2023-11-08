import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for ProjectFeatureSetsApi
void main() {
  final instance = Openapi().getProjectFeatureSetsApi();

  group(ProjectFeatureSetsApi, () {
    // Setup Feature Sets
    //
    //Future<BuiltList<ProjectFeatureSetGet>> setupFeatureSets(int taskId, int wsId, BuiltList<int> requestBody, { int permissionTaskId }) async
    test('test setupFeatureSets', () async {
      // TODO
    });
  });
}
