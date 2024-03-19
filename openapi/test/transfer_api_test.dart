import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TransferApi
void main() {
  final instance = Openapi().getTransferApi();

  group(TransferApi, () {
    // Create From Template
    //
    //Future<TasksChanges> createFromTemplate(int srcWsId, int srcProjectId, int wsId) async
    test('test createFromTemplate', () async {
      // TODO
    });

    // Project Templates
    //
    //Future<BuiltList<ProjectGet>> projectTemplates(int wsId) async
    test('test projectTemplates', () async {
      // TODO
    });
  });
}
