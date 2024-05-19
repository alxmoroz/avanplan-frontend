import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyApi
void main() {
  final instance = Openapi().getMyApi();

  group(MyApi, () {
    // Projects
    //
    // Мои проекты, куда у меня есть доступ, в том числе Входящие
    //
    //Future<BuiltList<TaskGet>> myProjects(int wsId, { bool closed, bool imported }) async
    test('test myProjects', () async {
      // TODO
    });

    // Tasks
    //
    // Мои задачи
    //
    //Future<BuiltList<TaskGet>> myTasks(int wsId, { int projectId }) async
    test('test myTasks', () async {
      // TODO
    });
  });
}
