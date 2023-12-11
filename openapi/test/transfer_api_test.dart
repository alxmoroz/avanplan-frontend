import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TransferApi
void main() {
  final instance = Openapi().getTransferApi();

  group(TransferApi, () {
    // Project Templates
    //
    //Future<BuiltList<ProjectGet>> projectTemplates(int wsId) async
    test('test projectTemplates', () async {
      // TODO
    });

    // Transfer Project
    //
    //Future<TasksChanges> transferProject(int srcWsId, int srcProjectId, int wsId) async
    test('test transferProject', () async {
      // TODO
    });
  });
}
