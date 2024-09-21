import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WSMyApi
void main() {
  final instance = Openapi().getWSMyApi();

  group(WSMyApi, () {
    // Projects
    //
    // Мои проекты, куда у меня есть доступ, в том числе Входящие
    //
    //Future<BuiltList<TaskGet>> myProjects(int wsId, { bool closed, bool imported, int taskId }) async
    test('test myProjects', () async {
      // TODO
    });

    // Tasks
    //
    // Мои задачи
    //
    //Future<BuiltList<TaskGet>> myTasks(int wsId, { int projectId, int taskId }) async
    test('test myTasks', () async {
      // TODO
    });
  });
}
