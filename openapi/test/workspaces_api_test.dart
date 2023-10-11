import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WorkspacesApi
void main() {
  final instance = Openapi().getWorkspacesApi();

  group(WorkspacesApi, () {
    // Create Workspace
    //
    //Future<WorkspaceGet> createWorkspaceV1WorkspacesPost({ WorkspaceUpsert workspaceUpsert }) async
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

    // Update Workspace
    //
    //Future<WorkspaceGet> updateWorkspaceV1WorkspacesWsIdPost(int wsId, WorkspaceUpsert workspaceUpsert) async
    test('test updateWorkspaceV1WorkspacesWsIdPost', () async {
      // TODO
    });
  });
}
