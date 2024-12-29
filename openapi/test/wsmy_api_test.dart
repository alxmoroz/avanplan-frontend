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
    //Future<BuiltList<TaskGet>> myProjects_0(int wsId, { bool closed, bool imported, int taskId }) async
    test('test myProjects_0', () async {
      // TODO
    });

    // Tasks
    //
    // Мои задачи
    //
    //Future<BuiltList<TaskGet>> myTasks_0(int wsId, { int projectId, int taskId }) async
    test('test myTasks_0', () async {
      // TODO
    });
  });
}
