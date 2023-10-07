import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyProjectsApi
void main() {
  final instance = Openapi().getMyProjectsApi();

  group(MyProjectsApi, () {
    // My Projects
    //
    //Future<BuiltList<TaskGet>> myProjectsV1MyProjectsGet(int wsId, { bool closed, bool imported }) async
    test('test myProjectsV1MyProjectsGet', () async {
      // TODO
    });
  });
}
