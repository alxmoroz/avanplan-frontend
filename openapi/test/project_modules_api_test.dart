import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for ProjectModulesApi
void main() {
  final instance = Openapi().getProjectModulesApi();

  group(ProjectModulesApi, () {
    // Setup Project Modules
    //
    //Future<BuiltList<ProjectModuleGet>> setupProjectModules(int taskId, int wsId, BuiltList<String> requestBody) async
    test('test setupProjectModules', () async {
      // TODO
    });
  });
}
