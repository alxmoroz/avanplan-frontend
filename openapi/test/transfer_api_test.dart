import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TransferApi
void main() {
  final instance = Openapi().getTransferApi();

  group(TransferApi, () {
    // Create From Template
    //
    //Future<TasksChanges> createFromTemplate(int wsId, int srcProjectId, int srcWsId, { int srcTaskId, int taskId }) async
    test('test createFromTemplate', () async {
      // TODO
    });

    // Destinations For Move
    //
    //Future<BuiltList<TaskGet>> destinationsForMove(int wsId, String taskType, { int taskId }) async
    test('test destinationsForMove', () async {
      // TODO
    });

    // Project Templates
    //
    //Future<BuiltList<ProjectGet>> projectTemplates(int wsId) async
    test('test projectTemplates', () async {
      // TODO
    });

    // Sources For Move
    //
    //Future<BuiltList<TaskGet>> sourcesForMoveTasks(int wsId, { int taskId }) async
    test('test sourcesForMoveTasks', () async {
      // TODO
    });
  });
}
