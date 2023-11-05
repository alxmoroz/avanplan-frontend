import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for StatusesApi
void main() {
  final instance = Openapi().getStatusesApi();

  group(StatusesApi, () {
    // Delete
    //
    //Future<bool> statusesDelete(int statusId, int wsId) async
    test('test statusesDelete', () async {
      // TODO
    });

    // Upsert
    //
    //Future<StatusGet> statusesUpsert(int wsId, StatusUpsert statusUpsert) async
    test('test statusesUpsert', () async {
      // TODO
    });

    // Statuses
    //
    //Future<BuiltList<StatusGet>> statusesV1WorkspacesWsIdStatusesGet(int wsId) async
    test('test statusesV1WorkspacesWsIdStatusesGet', () async {
      // TODO
    });
  });
}
