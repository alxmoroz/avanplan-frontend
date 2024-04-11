import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyProjectsApi
void main() {
  final instance = Openapi().getMyProjectsApi();

  group(MyProjectsApi, () {
    // My Projects
    //
    // Мои проекты, куда у меня есть доступ
    //
    //Future<BuiltList<TaskGet>> myProjects(int wsId, { bool closed, bool imported }) async
    test('test myProjects', () async {
      // TODO
    });
  });
}
