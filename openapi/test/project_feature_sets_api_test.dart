import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for ProjectFeatureSetsApi
void main() {
  final instance = Openapi().getProjectFeatureSetsApi();

  group(ProjectFeatureSetsApi, () {
    // Setup Project Feature Sets
    //
    //Future<BuiltList<ProjectFeatureSetGet>> setupProjectFeatureSets(int taskId, int wsId, BuiltList<int> requestBody) async
    test('test setupProjectFeatureSets', () async {
      // TODO
    });
  });
}
