import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WSTransferApi
void main() {
  final instance = Openapi().getWSTransferApi();

  group(WSTransferApi, () {
    // Create From Template
    //
    //Future<TasksChanges> createFromTemplate_0(int wsId, int srcProjectId, int srcWsId, { int srcTaskId, int taskId }) async
    test('test createFromTemplate_0', () async {
      // TODO
    });

    // Destinations For Move
    //
    //Future<BuiltList<TaskGet>> destinationsForMove_0(int wsId, String taskType, { int taskId }) async
    test('test destinationsForMove_0', () async {
      // TODO
    });

    // Project Templates
    //
    //Future<BuiltList<ProjectGet>> projectTemplates_0(int wsId) async
    test('test projectTemplates_0', () async {
      // TODO
    });

    // Sources For Move
    //
    //Future<BuiltList<TaskGet>> sourcesForMoveTasks_0(int wsId, { int taskId }) async
    test('test sourcesForMoveTasks_0', () async {
      // TODO
    });
  });
}
