import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WorkspacesApi
void main() {
  final instance = Openapi().getWorkspacesApi();

  group(WorkspacesApi, () {
    // Available Tariffs
    //
    //Future<BuiltList<TariffGet>> availableTariffsV1WorkspacesWsIdTariffsGet(int wsId) async
    test('test availableTariffsV1WorkspacesWsIdTariffsGet', () async {
      // TODO
    });

    // Create Workspace
    //
    //Future<WorkspaceGet> createWorkspaceV1WorkspacesPost() async
    test('test createWorkspaceV1WorkspacesPost', () async {
      // TODO
    });

    // Get My Workspaces
    //
    //Future<BuiltList<WorkspaceGet>> getMyWorkspacesV1WorkspacesGet() async
    test('test getMyWorkspacesV1WorkspacesGet', () async {
      // TODO
    });

    // Get Workspace
    //
    //Future<WorkspaceGet> getWorkspaceV1WorkspacesWsIdGet(int wsId) async
    test('test getWorkspaceV1WorkspacesWsIdGet', () async {
      // TODO
    });

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

    // Update Workspace
    //
    //Future<WorkspaceGet> updateWorkspaceV1WorkspacesWsIdPost(int wsId, WorkspaceUpsert workspaceUpsert) async
    test('test updateWorkspaceV1WorkspacesWsIdPost', () async {
      // TODO
    });
  });
}
