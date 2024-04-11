import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyTasksApi
void main() {
  final instance = Openapi().getMyTasksApi();

  group(MyTasksApi, () {
    // My Tasks
    //
    // Мои задачи
    //
    //Future<BuiltList<TaskGet>> myTasks(int wsId) async
    test('test myTasks', () async {
      // TODO
    });
  });
}
