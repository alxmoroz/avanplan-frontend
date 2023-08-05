import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyTasksApi
void main() {
  final instance = Openapi().getMyTasksApi();

  group(MyTasksApi, () {
    // My Tasks
    //
    //Future<BuiltList<TaskGet>> myTasksV1MyTasksGet(int wsId) async
    test('test myTasksV1MyTasksGet', () async {
      // TODO
    });
  });
}
